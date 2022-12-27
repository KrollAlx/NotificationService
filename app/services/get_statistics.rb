class GetStatistics
  class << self
    include Dry::Monads[:result]

    def call
      notifications = Notification.includes(:messages).all
      Success(notifications)
    end
  end
end