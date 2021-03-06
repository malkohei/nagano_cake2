class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @quantity = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(item_id: @item.id)
  end

end
