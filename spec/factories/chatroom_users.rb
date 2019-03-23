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

FactoryBot.define do
  factory :chatroom_user do
    user
    chatroom { nil }
  end
end
