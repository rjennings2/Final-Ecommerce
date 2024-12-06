class OrdersController < ApplicationController
  include TaxesHelper

  before_action :set_order, only: [:show]

  def show
    @order = Order.find(params[:id])
  end

  def new
    @cart = current_cart
    @products = Product.where(id: @cart.map { |item| item[:product_id] })
    @total_price = @products.sum { |product| product.price * @cart.find { |item| item[:product_id] == product.id }[:quantity] }

    @province = current_customer.province
    @taxes = calculate_taxes(@province, @total_price)
    @total_with_taxes = @total_price + @taxes[:gst] + @taxes[:pst] + @taxes[:hst]
  end

  def create
    @cart = current_cart
    @products = Product.where(id: @cart.map { |item| item[:product_id] })
    @total_price = @products.sum { |product| product.price * @cart.find { |item| item[:product_id] == product.id }[:quantity] }

    @province = current_customer.province
    @taxes = calculate_taxes(@province, @total_price)
    @total_with_taxes = @total_price + @taxes[:gst] + @taxes[:pst] + @taxes[:hst]

    @order = Order.new(customer_id: current_customer.id, total_price: @total_with_taxes, shipping_address: current_customer.address)

    if @order.save
      @cart.each do |cart_item|
        OrderItem.create(
          order_id: @order.id,
          product_id: cart_item[:product_id],
          quantity: cart_item[:quantity],
          price: Product.find(cart_item[:product_id]).price
        )
      end
      session[:cart] = nil
      redirect_to order_path(@order), notice: 'Your order has been placed successfully!'
    else
      render :new, alert: 'There was an issue placing your order.'
    end
  end

  def confirmed
    @cart_items = current_cart.map do |item|
      product = Product.find(item[:product_id])
      {
        product: product,
        quantity: item[:quantity],
        subtotal: product.price * item[:quantity]
      }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end