class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :workshop

  after_create :update_workshop_seats

  def update_workshop_seats
    workshop.update(remaining_seats: workshop.total_seats - total_tickets)
  end
end
