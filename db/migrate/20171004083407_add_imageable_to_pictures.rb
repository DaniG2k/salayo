class AddImageableToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :description, :string
    add_reference :pictures, :imageable, polymorphic: true, index: true
  end
end
