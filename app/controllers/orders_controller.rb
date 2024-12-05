class OrdersController < ApplicationController
  include TaxesHelper  # Include the tax calculation helper

  before_action :set_order, only: [:show]

  def show
    # @order is set by the set_order before_action
    @order = Order.find(params[:id])
  end

  # Show the invoice before the order is placed
  def new
    @cart = current_cart
    @products = Product.where(id: @cart.map { |item| item[:product_id] })
    @total_price = @products.sum { |product| product.price * @cart.find { |item| item[:product_id] == product.id }[:quantity] }

    # Get the user's province and calculate taxes
    @province = current_customer.province
    @taxes = calculate_taxes(@province, @total_price)
    @total_with_taxes = @total_price + @taxes[:gst] + @taxes[:pst] + @taxes[:hst]
  end

  # Place the order and save it to the database
  def create
    @cart = current_cart
    @products = Product.where(id: @cart.map { |item| item[:product_id] })
    @total_price = @products.sum { |product| product.price * @cart.find { |item| item[:product_id] == product.id }[:quantity] }

    # Get the user's province and calculate taxes
    @province = current_customer.province
    @taxes = calculate_taxes(@province, @total_price)
    @total_with_taxes = @total_price + @taxes[:gst] + @taxes[:pst] + @taxes[:hst]

    # Create a new order for the customer
    @order = Order.new(customer_id: current_customer.id, total_price: @total_with_taxes, shipping_address: current_customer.address)

    if @order.save
      # Save the order items
      @cart.each do |cart_item|
        OrderItem.create(
          order_id: @order.id,
          product_id: cart_item[:product_id],
          quantity: cart_item[:quantity],
          price: Product.find(cart_item[:product_id]).price
        )
      end
      # Clear the cart
      session[:cart] = nil
      redirect_to order_path(@order), notice: 'Your order has been placed successfully!'
    else
      render :new, alert: 'There was an issue placing your order.'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end