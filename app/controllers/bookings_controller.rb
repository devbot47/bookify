class BookingsController < ApplicationController

  def create

    @stripe_service    = StripeService.new
    @workshop          = Workshop.find(params[:workshop_id])
    @user              = current_user
    @stripe_customer   = @stripe_service.find_or_create_user(@user)
    @card              = @stripe_service.create_stripe_customer_card(card_params, @stripe_customer)
    @amount_to_be_paid = params[:total_tickets].to_i * @workshop.registration_fee
    @charge            = @stripe_service.create_stripe_charge(@amount_to_be_paid, @stripe_customer.id, @card.id, @workshop)
    @booking           = Booking.new(booking_params.merge({amount_paid: @amount_to_be_paid, stripe_transaction_id: @charge.id}))

    if @charge && @booking.save!
      BookingsMailer.booking_confirmation(@booking).deliver_now
      redirect_to workshop_path(@workshop), notice: "You have successfully booked #{@booking.total_tickets} tickets for #{@workshop.name} workshop."
    end

    rescue Stripe::StripeError => error
      redirect_to workshop_path(@workshop), alert: "#{error.message}"

  end

  private

  def card_params
    params.permit(:card_number, :exp_year, :exp_month, :cvc)
  end

  def booking_params
    params.permit(:total_tickets, :user_id, :workshop_id)
  end

end