class AddAttributesToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :property_type, :string
    add_column :listings, :lat, :float
    add_column :listings, :lng, :float
  end
end
