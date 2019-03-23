class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name, null: false
      t.integer :bathrooms, default: 0
      t.integer :bedrooms, default: 0
      t.integer :beds, default: 0
      t.text :description
      t.string :property_type
      t.float :lat, null: false
      t.float :lng, null: false
      t.string :country_name
      t.string :country_code
      t.string :state
      t.string :city
      t.string :address
      t.text :amenities, array: true, default: []
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
