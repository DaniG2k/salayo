class RemoveListingImagesFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :listing_images, :json
  end
end
