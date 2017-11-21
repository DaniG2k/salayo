FactoryBot.define do
  factory :advertisement do
    user nil
    ad_type %w(rent let wanted).sample
    title 'In search of a roommmate'
    body 'I am a nice guy, really! Help me find a house.'
  end
end
