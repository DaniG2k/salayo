class RemoveTypeFromAdvertisements < ActiveRecord::Migration[5.1]
  def change
    remove_column :advertisements, :type, :string
  end
end
