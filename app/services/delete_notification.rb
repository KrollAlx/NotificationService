class DeleteNotification
  class << self
    include Dry::Monads[:result]

    def call(params)
      begin
        notification = Notification.find(params[:id])

        notification.delete

        Success('Notification deleted')
      rescue ActiveRecord::RecordNotFound
        return Failure('Notification not found')
      end
    end
  end
end