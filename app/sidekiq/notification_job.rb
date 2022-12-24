class NotificationJob
  include Sidekiq::Job

  def perform(notification)

  end
end
