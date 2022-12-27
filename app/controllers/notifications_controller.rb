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
    result = GetDetails.call(params)
    if result.success?
      notification = result.success
      render json: notification, status: :ok
    else
      render json: result.failure, status: :not_found
    end
  end

  def update
    result = UpdateNotification.call(params)
    if result.success?
      notification = result.success
      render json: notification, status: :ok
    else
      if result.failure == 'Notification not found'
        render json: result.failure, status: :not_found
      else
        render json: result.failure, status: :unprocessable_entity
      end
    end
  end

  def delete
    result = DeleteNotification.call(params)
    if result.success?
      render json: result.success, status: :ok
    else
      render json: result.failure, status: :not_found
    end
  end
end
