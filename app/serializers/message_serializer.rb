class MessageSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :status, :notification_id, :client_id
end
