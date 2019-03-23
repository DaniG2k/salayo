# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#  ad_type    :string
#  title      :string
#  slug       :string
#

RSpec.describe Advertisement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
