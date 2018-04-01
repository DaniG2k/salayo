class AmenityList < ApplicationRecord
  belongs_to :listing

  validates(
    :air_conditioning,
    :intercom,
    :cable_tv,
    :doorman,
    :dryer,
    :elevator,
    :essentials,
    :gym,
    :hair_dryer,
    :hangers,
    :heating,
    :hot_tub,
    :internet,
    :iron,
    :kitchen,
    :parking,
    :pool,
    :refrigerator,
    :tv,
    :washer,
    inclusion: [true, false]
  )
end
