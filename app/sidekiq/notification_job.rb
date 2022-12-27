require 'rest-client'

class NotificationJob
  include Sidekiq::Job

  def perform(notification_id)
    notification = Notification.find(notification_id)
    clients = Client.where(tag: notification.filter).or(Client.where(operator_code: notification.filter))

    send_service_url = ENV.fetch("SEND_SERVICE_URL")
    auth_token = ENV.fetch("TOKEN")

    clients.each do |client|
      begin
        message = Message.create(created_at: DateTime.now, notification: notification, client: client, status: 0)
        response = RestClient.post(send_service_url + message.id,
                                   {id: message.id.to_i,
                                    phone: client.phone_number.to_i,
                                    text: notification.text},
                                   {Authorization: "Bearer " + auth_token})

        if response.code == 200 && response.body == {code: message.id.to_i, message: notification.text}.to_json
          message.sent!
        end
      rescue RestClient::ExceptionWithResponse => err
        err.response
      end
    end
  end
end
