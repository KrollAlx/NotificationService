class GetDetails
  class << self
    include Dry::Monads[:result]

    def call(params)
      begin
        notification = Notification.includes(:messages).find(params[:id])
        Success(notification)
      rescue ActiveRecord::RecordNotFound
        return Failure('Notification not found')
      end
    end
  end
end