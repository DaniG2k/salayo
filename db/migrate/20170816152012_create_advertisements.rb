class CreateAdvertisements < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisements do |t|
      t.string :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
