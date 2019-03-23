class MonetizeListings < ActiveRecord::Migration[5.1]
  def change
    add_monetize :listings, :price, amount: { null: false, default: 0.0 }
  end
end
