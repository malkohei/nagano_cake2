class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "商品を追加しました。"
      redirect_to admin_item_path(@item.id)
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "商品情報を更新しました。"
      redirect_to admin_item_path
    end
  end

  private

    def item_params
      params.require(:item).permit(:name, :image, :price, :introduction, :is_active)
    end

end
