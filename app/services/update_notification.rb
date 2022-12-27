class UpdateNotification
  class << self
    include Dry::Monads[:result]

    def call(params)
      begin
        notification = Notification.find(params[:id])

        contract = NotificationContract.new
        result = contract.call(start_at: params[:start_at],
                               end_at: params[:end_at],
                               text: params[:text],
                               filter: params[:filter])

        unless result.success?
          return Failure(result.errors)
        end

        notification.update(start_at: params[:start_at],
                            end_at: params[:end_at],
                            text: params[:text],
                            filter: params[:filter])

        Success(notification)
      rescue ActiveRecord::RecordNotFound
        return Failure('Notification not found')
      end
    end
  end
end