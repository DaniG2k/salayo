FactoryBot.define do
  factory :amenity_list do
    listing { nil }
    air_conditioning { [true, false].sample }
    intercom { [true, false].sample }
    cable_tv { [true, false].sample }
    doorman { [true, false].sample }
    dryer { [true, false].sample }
    elevator { [true, false].sample }
    essentials { [true, false].sample }
    gym { [true, false].sample }
    hair_dryer { [true, false].sample }
    hangers { [true, false].sample }
    heating { [true, false].sample }
    hot_tub { [true, false].sample }
    internet { [true, false].sample }
    iron { [true, false].sample }
    kitchen { [true, false].sample }
    parking { [true, false].sample }
    pool { [true, false].sample }
    refrigerator { [true, false].sample }
    tv { [true, false].sample }
    washer { [true, false].sample }
  end
end
