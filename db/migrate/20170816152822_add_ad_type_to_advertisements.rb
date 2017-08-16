class AddAdTypeToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :ad_type, :string
  end
end
