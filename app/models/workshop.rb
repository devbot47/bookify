class Workshop < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged
  has_many :bookings
  has_many :users, through: :bookings

  validates :name, :description, presence: true
  validates :start_date, :end_date, :start_time, :end_time, presence: true
  validates :total_seats, :registration_fee, presence: true, numericality: true
  validates :end_date, comparison: {greater_than: :start_date, message: 'cannot be before start date'}

  before_create :set_slug
  scope :upcoming_workshops, -> { where('start_date > ?', Date.today) }
  scope :past_workshops, -> { where('start_date < ?', Date.today) }

  def is_upcoming_workshop?
    start_date < Date.today
  end

  def set_slug
    self.slug = SecureRandom.urlsafe_base64(5, false) if self.slug.nil?
  end

end
