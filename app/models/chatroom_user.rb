# == Schema Information
#
# Table name: chatroom_users
#
#  id          :integer          not null, primary key
#  chatroom_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ChatroomUser < ApplicationRecord
  # Associations
  belongs_to :chatroom
  belongs_to :user
end
