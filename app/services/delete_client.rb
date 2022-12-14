class DeleteClient
  class << self
    include Dry::Monads[:result]

    def call(params)
      begin
        client = Client.find(params[:id])

        client.delete

        Success('Client deleted')
      rescue ActiveRecord::RecordNotFound
        return Failure('Client not found')
      end
    end
  end
end