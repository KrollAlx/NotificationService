require 'dry-monads'

class CreateClient
  class << self
    include Dry::Monads[:result]

    def call(params)
      contract = ClientContract.new
      result = contract.call(phone_number: params[:phone_number],
                            operator_code: params[:operator_code],
                            tag: params[:tag],
                            timezone: params[:timezone])

      unless result.success?
        return Failure(result.errors)
      end

      client = Client.create(phone_number: params[:phone_number],
                             operator_code: params[:operator_code],
                             tag: params[:tag],
                             timezone: params[:timezone])
      Success(client)
    end
  end
end