class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :contact_number
      t.decimal :cost_price, :precision => 5, :scale => 2, :default => 0.00
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
