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

FactoryBot.define do
  factory :advertisement do
    user
    ad_type { %w[rent let wanted].sample }
    title { 'In search of a roommmate' }
    body { 'I am a nice guy, really! Help me find a house.' }
  end
end
