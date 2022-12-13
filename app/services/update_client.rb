class UpdateClient
  class << self
    include Dry::Monads[:result]

    def call(params)
      begin
        client = Client.find(params[:id])

        contract = ClientContract.new
        result = contract.call(phone_number: params[:phone_number],
                               operator_code: params[:operator_code],
                               tag: params[:tag],
                               timezone: params[:timezone])

        unless result.success?
          return Failure(result.errors)
        end

        client.update(phone_number: params[:phone_number],
                      operator_code: params[:operator_code],
                      tag: params[:tag],
                      timezone: params[:timezone])

        Success(client)
      rescue ActiveRecord::RecordNotFound
        return Failure('Client not found')
      end
    end
  end
end