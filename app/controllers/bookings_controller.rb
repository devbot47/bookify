class BookingsController < ApplicationController

  before_action :set_attributes, :check_valid_workshop, :charge_for_booking, only: [:create]

  def create
    @booking = Booking.new(booking_params.merge(
      {
        user_id: @user.id,
        workshop_id: @workshop.id,
        amount_paid: @amount_to_be_paid,
        stripe_transaction_id: @charge.id
      }))
    debugger
    if @booking.save!
      BookingsMailer.booking_confirmation(@booking).deliver_now
      redirect_to workshop_path(@workshop), notice: "You have successfully booked #{@booking.total_tickets} tickets for #{@workshop.name} workshop."
    end
  end

  private

  def card_params
    params.permit(:card_number, :exp_year, :exp_month, :cvc)
  end

  def booking_params
    params.permit(:total_tickets, :user_id, :workshop_id)
  end

  def set_attributes
    @stripe_service    = StripeService.new
    @workshop          = Workshop.friendly.find(params[:workshop_id])
    @user              = User.friendly.find(params[:user_id])
  end

  def charge_for_booking
    @stripe_customer   = @stripe_service.find_or_create_user(@user)
    @card              = @stripe_service.create_stripe_customer_card(card_params, @stripe_customer)
    @amount_to_be_paid = params[:total_tickets].to_i * @workshop.registration_fee
    @charge            = @stripe_service.create_stripe_charge(@amount_to_be_paid, @stripe_customer.id, @card.id, @workshop)

    rescue Stripe::StripeError => error
      redirect_to workshop_path(@workshop), alert: "#{error.message}"
  end

  def check_valid_workshop
    if @workshop.is_upcoming_workshop? || @workshop.remaining_seats - params[:total_tickets].to_i < 0
      redirect_to workshop_path(@workshop), alert: "Sorry! cannot book your tickets. Please check remaining seats or start date for this workshop."
    end
  end
end