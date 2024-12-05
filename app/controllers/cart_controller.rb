class CartController < ApplicationController
  # Show the cart contents
  def show
    @cart = current_cart
    @products = Product.where(id: @cart.map { |item| item[:product_id] })
    Rails.logger.debug "Cart contents on show: #{@cart}"
    Rails.logger.debug "Products found: #{@products.inspect}"
  end

  # Add a product to the cart
  def add
    product = Product.find(params[:product_id])
    add_cart_path(product.id)  # Add product to the cart
    redirect_to cart_path, notice: "#{product.product_name} was added to your cart!"
  end

  # Remove a product from the cart
  def remove
    product = Product.find(params[:product_id])
    remove_from_cart(product.id)  # Remove product from the cart
    redirect_to cart_path, notice: "#{product.product_name} was removed from your cart!"
  end

  # Update the quantity of a product in the cart
  def update
    product = Product.find(params[:product_id])
    update_cart(product.id, params[:quantity])  # Update quantity
    redirect_to cart_path, notice: "Cart updated!"
  end
end