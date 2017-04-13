class OrdersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_journey, only: %i(new create checkout)
  before_action :set_order, only: %i(checkout charge)
  before_action :instantiate_order, only: %i(create)
  before_action :ensure_booking_is_active, only: %i(new checkout create)
  
  def checkout
  end
  
  def new
    @minutes = Order.calculate_not_paid_minutes(@journey)
    @order = Order.new
    authorize(@order)
  end 
  
  def create
    @order.calculate_consumer_total_cents!
    @order.state = Order::PENDING_PAYMENT
    authorize(@order)
    if @order.valid?
      if @order.save
        flash[:notice] = t 'orders.create.success'
        redirect_to dashboard_path
      else
        flash[:alert] = @order.errors.full_messages
        handle_errors
      end
    else
      flash[:alert] = @order.errors.full_messages
      handle_errors
    end
  end
  
  def charge
      
    if @order.payable?
      
      charge = Stripe::Charge.create(
        source:       params[:stripeToken],
        amount:       @order.consumer_total_cents, 
        description:  @order.charge_description,
        currency:     Order::STRIPE_EUR
      )
      
      if @order.update(payment: charge.to_json, state: Order::PAID, stripe_charge_id: charge.id )
        flash[:notice] = t '.success'
        redirect_to dashboard_path
      else
        @order.reload # for cleaning up any possibly modified attributes
        flash[:alert] = t 'stripe.payment_failed'
        redirect_to @order.payment_link
      end 
      
    else
      error = t '.already_charged'
      SafeLoggerRaygun.error { error }
      flash[:alert] = error
      redirect_to dashboard_path
    end
  
  rescue Stripe::CardError => e
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

  def handle_errors
    redirect_to dashboard_path
  end
  
  def instantiate_order
    @order = Order.new(order_params)
  end
  
  def ensure_booking_is_active
    if @journey.completed
      flash[:alert] = t 'orders.errors.booking_is_completed'
      redirect_to dashboard_path
    end
  end
  
end