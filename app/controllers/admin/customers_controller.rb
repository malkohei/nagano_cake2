class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page])
  end

  def edit
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
  end

  private

    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :telephone_number, :email, :is_deleted)
    end
end
