class OrdersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_journey, only: %i(new create checkout)
  before_action :set_order, only: %i(checkout charge)
  before_action :instantiate_order, only: %i(create)
  before_action :ensure_booking_is_active, only: %i(new checkout create)
  
  def checkout
  end
  
  def new
    @minutes = Order.calculate_minutes(@journey)
    @order = Order.new
    authorize(@order)
  end 
  
  def create
    @order.calculate_consumer_total_cents
    @order.state = Order::NOT_PAID
    if @order.valid?
      authorize(@order)
      if @order.save
        flash[:success] = t 'orders.create.success'
        redirect_to dashboard_path
      else
        flash.now[:alert] = t 'orders.create.unexpected_error'
        handle_errors
      end
    else
      flash.now[:alert] = t 'orders.create.validation_error'
      authorize(@order)
      handle_errors
    end
  end
  
  def charge
    
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
    
    if @order.update(payment: charge.to_json, state: Order::PAID)
      flash[:notice] = t '.success'
      redirect_to dashboard_path
    end 
    rescue Stripe::CardError => e
      @order.reload # for cleaning up any possibly modified attributes
      flash[:alert] = e.message
      redirect_to @order.payment_link
      
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
    render 'orders/new'
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
  
  helper_method :convert_to_hours
  
  def convert_to_hours(minutes)
    (minutes.to_f/60).round(1)  
  end
  
end