class Message < ApplicationRecord
  belongs_to :notification
  belongs_to :client
  enum :status, [:not_sent, :sent]
end
