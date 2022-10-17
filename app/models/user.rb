class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend FriendlyId
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  before_create :set_slug
  friendly_id :slug, use: :slugged
  has_many :bookings
  has_many :workshops, through: :bookings
  validates :full_name, :contact_number, presence: true
  validates :email, presence: true, uniqueness: true

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(5, false) if self.slug.nil?
  end

end
