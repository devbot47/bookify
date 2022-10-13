class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  has_many :bookings
  has_many :workshops, through: :bookings
  validates :full_name, :contact_number, presence: true
  validates :email, presence: true, uniqueness: true

end
