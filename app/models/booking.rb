class Booking < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  validates_presence_of :booking_date, :number_of_seats, :booking_time, :restaurant
end
