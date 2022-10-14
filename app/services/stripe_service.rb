require 'stripe'
class StripeService

  def initialize()
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end

  def find_or_create_user(user)
    if user.stripe_customer_id.present?
      stripe_user = Stripe::Customer.retrieve(user.stripe_customer_id)
    else
      stripe_user = Stripe::Customer.create({
                            name: user.full_name,
                            email: user.email,
                            phone: user.contact_number
                          })
      user.update(stripe_customer_id: stripe_user.id)
      stripe_user
    end
  end

  def create_card_token(params)
    card = Stripe::Token.create({
                   card: {
                     number: params[:card_number].to_s,
                     exp_month: params[:month],
                     exp_year: params[:year],
                     cvc: params[:cvc],
                   },
                 })
    card
  end

  def create_stripe_customer_card(params, user)
    token = create_card_token(params)
    Stripe::Customer.create_source(
      user.id,
      {source: token.id}
    )
  end

end