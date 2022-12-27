class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :end_at, :text, :filter
  has_many :messages
end
