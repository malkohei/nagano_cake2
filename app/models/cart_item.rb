class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def subtotal_price
    amount * 1.1 * item.price
  end

end
