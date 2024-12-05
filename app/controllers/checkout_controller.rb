class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def show
    # Assuming you're using a current_customer helper to fetch the logged-in customer
    @customer = current_customer
    # Optionally, if using an Order model, you can set the order:
    @order = Order.new
  end
end