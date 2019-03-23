RSpec.describe AmenityList, type: :model do
  context 'validations' do
    it 'validates with the proper attributes' do
      amenity_list = AmenityList.new(
        air_conditioning: true,
        intercom: true,
        cable_tv: true,
        doorman: true,
        dryer: true,
        elevator: true,
        essentials: true,
        gym: true,
        hair_dryer: true,
        hangers: true,
        heating: true,
        hot_tub: true,
        internet: true,
        iron: true,
        kitchen: true,
        parking: true,
        pool: true,
        refrigerator: true,
        tv: true,
        washer: true
      )
      expect(amenity_list).to be_valid
    end

    it 'does not validate when attributes are missing' do
      amenity_list = AmenityList.new(
        air_conditioning: nil
      )
      expect(amenity_list).not_to be_valid
    end
  end
end
