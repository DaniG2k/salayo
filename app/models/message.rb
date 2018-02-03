class Message < ApplicationRecord
  # Associations
  belongs_to :chatroom
  belongs_to :user
end
