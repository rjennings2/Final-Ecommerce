class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # Optionally add a method to calculate the total price of the cart
  def total_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end