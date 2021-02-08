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
    @order.save
    redirect_to confirm_orders_path(@order)
  end

  def confirm
    @order = Order.find(params[:id])
  end

  def thanks
  end

  def index
  end

  def show
  end
end
