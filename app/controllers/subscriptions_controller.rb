class SubscriptionsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]
  require 'json'

  def new
    @subscription = current_user.subscription
    if not @subscription.stripe_customer_token.blank?
      @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
      @current_period_start = @subscription.current_period_start
      @current_period_end = @subscription.current_period_end
      @cancel_at_period_end = @customer["subscription"]["cancel_at_period_end"]
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payments_path
  end

  def cancel 
    @subscription = current_user.subscription
    @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
    @customer.cancel_subscription(:at_period_end => true)
    redirect_to payments_path, :notice => "Alright, we've canceled your subscription. We'll miss you!"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payments_path
  end

  def resubscribe
    @subscription = current_user.subscription
    @subscription.plan_id = 2 #This is the plan id.. when new plans come do a select
    @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
    @subscription.current_period_start = DateTime.strptime(@customer["subscription"]["current_period_start"].to_s,'%s')
    @subscription.current_period_end = DateTime.strptime(@customer["subscription"]["current_period_end"].to_s,'%s')
    @subscription.save!
    @customer.update_subscription(:plan => @subscription.plan_id)
    flash[:success] = "Thank you for resubscribing, you're the best!"
    redirect_to payments_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payments_path
  end

  def create
    @subscription = current_user.subscription
    @subscription.plan_id = 2 #This is the plan id.. when new plans come do a select
    @customer = Stripe::Customer.create(description: current_user.email, email: current_user.email, plan: @subscription.plan_id, card: params[:stripeToken])
    @subscription.current_period_start = DateTime.strptime(@customer["subscription"]["current_period_start"].to_s,'%s')
    @subscription.current_period_end = DateTime.strptime(@customer["subscription"]["current_period_end"].to_s,'%s')
    @subscription.stripe_customer_token = @customer.id
    @subscription.save!
    redirect_to payments_path, :notice => "Thank you for subscribing!"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payments_path
  end

  def show
    @subscription = Subscription.find(params[:id])
    # Parse JSON
    require 'json'
    cu = Stripe::Customer.retrieve("cus_2Qg9zWEr0aYPR0")
    event_data = JSON.parse(json)

  end
end
