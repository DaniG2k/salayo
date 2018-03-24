# == Schema Information
#
# Table name: chatrooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chatroom < ApplicationRecord
  # Associations
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages
end
