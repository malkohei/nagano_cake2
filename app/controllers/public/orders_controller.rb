class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = current_customer.orders.new
  end

  def confirm
    @order = current_customer.orders.new
    @cart_items = current_customer.cart_items
    session[:order] = Order.new()
    session[:order][:customer_id] = current_customer.id
    session[:order][:payment_method] = params[:order][:payment_method]
    case params[:selected_status]
    when "0"
      session[:order][:postal_code] = current_customer.postal_code
      session[:order][:address] = current_customer.address
      session[:order][:name] = current_customer.last_name + current_customer.first_name
    when "1"
      session[:order][:postal_code] = params[:order][:postal_code]
      session[:order][:address] = params[:order][:address]
      session[:order][:name] = params[:order][:name]
    end
  end

  def create
    @order = Order.new(session[:order])
    cart_items = current_customer.cart_items

    sum = 0
    sub_total = 0

    cart_items.each do |cart_item|
      (cart_item.item.price * 1.1).round
      (cart_item.item.price * 1.1).round * cart_item.amount
      sub_total+=(cart_item.item.price * 1.1).round * cart_item.amount
      sum+=sub_total
      sum = sub_total + @order.shipping_cost
    end

    @order.total_payment = sum
    @order.save!


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
    session[:order].clear
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status,
                                  :selected_status => [ 0 , 1 ])
  end

end
