class AddBedroomsBathroomsBedsToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :bathrooms, :integer, default: 0
    add_column :listings, :bedrooms, :integer, default: 0
    add_column :listings, :beds, :integer, default: 0
  end
end
