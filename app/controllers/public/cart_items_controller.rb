class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    @cart_items = CartItem.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to cart_items_path,success: '個数を変更しました'
    else
      render :index, danger: "個数の変更に失敗しました。"
    end
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    if @cart_items.destroy
    redirect_to cart_items_path,success: '商品の削除が完了しました。'
    else
      render :index, danger: "商品の削除が出来ませんでした"
    end
  end

  def all_destroy
    customer = Customer.find(current_customer.id)
    if customer.cart_items.destroy_all
      redirect_to cart_items_path,success: 'カート内の商品を全て削除しました。'
    else
      render :index, danger: "カート内の商品を削除出来ませんでした。"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end
