class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restaurants
  has_many :bookings
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
end
