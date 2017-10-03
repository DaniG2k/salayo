class AddListingToPictures < ActiveRecord::Migration[5.1]
  def change
    add_reference :pictures, :listing, index: true, foreign_key: true
  end
end
