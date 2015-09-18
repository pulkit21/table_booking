class Restaurant < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :name, :address, :contact_number
  validates :cost_price, presence: { message: "Cost for Two can't be blank" }

end
