require 'dry-monads'

class CreateNotification
  class << self
    include Dry::Monads[:result]

    def call(params)
      contract = NotificationContract.new
      result = contract.call(start_at: params[:start_at],
                             end_at: params[:end_at],
                             text: params[:text],
                             filter: params[:filter])

      unless result.success?
        return Failure(result.errors)
      end

      notification = Notification.create(start_at: params[:start_at],
                                         end_at: params[:end_at],
                                         text: params[:text],
                                         filter: params[:filter])

      # бизнес логика запуска рассылки

      if correct_time?(notification)
        NotificationJob.perform_at(notification.start_at.to_datetime, notification.id)
      end

      Success(notification)
    end

    private

    def correct_time?(notification)
      notification.end_at.to_datetime >= DateTime.now
    end
  end
end