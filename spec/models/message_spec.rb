# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  chatroom_id :integer
#  user_id     :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

RSpec.describe Message, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
