class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all.includes(:customer)
    @orders = Order.page(params[:page]).per(10)
  end

end
