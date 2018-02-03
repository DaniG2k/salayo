class ChatroomUser < ApplicationRecord
  # Associations
  belongs_to :chatroom
  belongs_to :user
end
