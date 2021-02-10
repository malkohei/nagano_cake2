class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = current_customer.orders.new
  end

  def create
    @order = current_customer.orders.new(order_params)
    case params[:address_type]
    when "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    end
    if @order.save
      redirect_to confirmation_order_path(@order)
    end
  end

  def confirmation
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
  end

  def confirm
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
    if @order.save!
      current_customer.cart_items.each do |cart_item|
        @order_details = OrderDetail.new(
          order_id: @order.id,
          item_id: cart_item.item_id,
          price: cart_item.item.price,
          amount: cart_item.amount)
        @order_details.save!
      end
      current_customer.cart_items.destroy_all
    end
    redirect_to thanks_orders_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
