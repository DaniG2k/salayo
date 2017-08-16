class AddBodyToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :body, :text
  end
end
