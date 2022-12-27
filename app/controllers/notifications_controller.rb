class NotificationsController < ApplicationController
  def create
    result = CreateNotification.call(params)
    if result.success?
      notification = result.success
      render json: notification, status: :created
    else
      render json: result.failure, status: :unprocessable_entity
    end
  end

  def statistics
    result = GetStatistics.call
    notifications = result.success
    render json: notifications, status: :ok
  end

  def details

  end

  def update

  end

  def delete

  end
end
