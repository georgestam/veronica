class OrdersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_journey, only: %i(new create checkout)
  before_action :set_order, only: %i(checkout charge)
  before_action :instantiate_order, only: %i(create)
  before_action :ensure_booking_is_active, only: %i(new checkout create)
  
  def checkout
  end
  
  def new
    @minutes = calculate_minutes
    @order = Order.new
    authorize(@order)
    # add here all the sum of all the minutes that have not been paid. 
  end 
  
  def create
    @order.consumer_total = @order.minutes * @order.price_hour / 60
    @order.state = 'not paid'
    if @order.valid?
      authorize(@order)
      if @order.save
        flash[:success] = t 'orders.create.success'
        redirect_to dashboard_path
      else
        flash.now[:error] = t 'orders.create.unexpected_error'
        handle_errors
      end
    else
      flash.now[:error] = t 'orders.create.validation_error'
      authorize(@order, :true?)
      handle_errors
    end
  end
  
  def charge
    
    # stripe_token = params.require :stripeToken
    # if @order.charge! stripe_token
    #   flash[:success] = t '.success'
    #   redirect_to @order.reservation_link
    # else
    #   @order.reload # for cleaning up any possibly modified attributes
    #   flash[:error] = t 'stripe.payment_failed'
    #   redirect_to @order.payment_link
    # end
    
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   
      amount:       @order.consumer_total_cents, 
      description:  @order.charge_description,
      currency:     @order.consumer_total.currency
    )
    
  @order.update(payment: charge.to_json, state: 'paid')
  flash[:success] = t '.success'
  redirect_to dashboard_path
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to dashboard_path
    
  end
  
  protected
  
  def set_journey
    @journey = Journey.find(params[:journey_id])
  end
  
  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end
  
  def order_params
    params.require(:order).permit(:minutes).merge(journey_id: @journey.id, price_hour: @journey.car.price_hour)
  end
  
  def ensure_order
    if current_user
      @order ||= Order.new
    end
  end
  
  def handle_errors
    ensure_order
    render 'oders/new'
  end
  
  def instantiate_order
    @order = Order.new(order_params)
  end
  
  def ensure_booking_is_active
    if @journey.completed
      flash[:error] = t 'orders.errors.booking_is_completed'
      redirect_to dashboard_path
    end
  end
  
  def calculate_minutes
    minutes_paid = calculate_minutes_paid
    imparted_hours = ImpartedHour.where(journey_id: @journey)
    minutes = { total_minutes: 0, minutes_paid: minutes_paid, minutes_not_paid: 0 }
  
    imparted_hours.each do |imparted_hour| 
      minutes[:total_minutes] += imparted_hour.minutes
    end 
  
    minutes[:minutes_not_paid] = minutes[:total_minutes] - minutes[:minutes_paid] 
    
    minutes
    
  end
  
  def calculate_minutes_paid
    
    orders = Order.where(journey_id: @journey).where(state: 'paid')
    minutes_paid = 0
    orders.each do |order| 
      amount = (order.consumer_total_cents / 100).to_i
      minutes_paid += amount * 60 / (order.price_hour)
    end 
    minutes_paid
    
  end
  
end