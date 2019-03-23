# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image          :string
#  description    :string
#  imageable_type :string
#  imageable_id   :integer
#

FactoryBot.define do
  factory :image do
  end
end
