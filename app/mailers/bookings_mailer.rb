class BookingsMailer < ApplicationMailer

  def booking_confirmation(booking)
    @booking = booking
    @user = booking.user
    @workshop = booking.workshop
    mail to: @user.email, subject: "Booking Confirmation for #{@workshop.name} workshop. "
  end

end
