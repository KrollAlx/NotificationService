class GetStatistics
  class << self
    include Dry::Monads[:result]

    def call
      # puts Notification.joins(:messages).select(:all).group('messages.status').count.to_sql
      notifications = Notification.includes(:messages).all
      # puts notifications
      Success(notifications)
    end
  end
end