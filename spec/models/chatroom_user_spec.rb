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

RSpec.describe ChatroomUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
