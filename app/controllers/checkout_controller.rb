class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
    @order = Order.new
  end
end