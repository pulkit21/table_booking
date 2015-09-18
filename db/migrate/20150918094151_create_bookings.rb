class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :booking_date
      t.integer :number_of_seats
      t.time :booking_time
      t.references :restaurant, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
