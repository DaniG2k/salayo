class CreateAmenityLists < ActiveRecord::Migration[5.1]
  def change
    create_table :amenity_lists do |t|
      t.references :listing, foreign_key: true
      t.boolean :air_conditioning, default: false
      t.boolean :intercom, default: false
      t.boolean :cable_tv, default: false
      t.boolean :doorman, default: false
      t.boolean :dryer, default: false
      t.boolean :elevator, default: false
      t.boolean :essentials, default: false
      t.boolean :gym, default: false
      t.boolean :hair_dryer, default: false
      t.boolean :hangers, default: false
      t.boolean :heating, default: false
      t.boolean :hot_tub, default: false
      t.boolean :internet, default: false
      t.boolean :iron, default: false
      t.boolean :kitchen, default: false
      t.boolean :parking, default: false
      t.boolean :pool, default: false
      t.boolean :refrigerator, default: false
      t.boolean :tv, default: false
      t.boolean :washer, default: false

      t.timestamps
    end
    remove_column :listings, :amenities
  end
end
