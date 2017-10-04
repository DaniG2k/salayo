class RemoveListingIdFromPictures < ActiveRecord::Migration[5.1]
  def change
    remove_column :pictures, :listing_id
  end
end
