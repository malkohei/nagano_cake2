class Public::CustomerController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to "/customer"
    else
      render action: :edit
    end
  end

  def out
    @customer = current_customer
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用をお待ちしております。"
    redirect_to root_path
  end

  def quit
  end

  private

  def user_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number)
  end
end
