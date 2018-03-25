class CreateContactMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
