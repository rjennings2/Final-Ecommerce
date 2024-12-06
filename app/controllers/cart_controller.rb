class CartController < ApplicationController
  before_action :set_cart, only: [:show, :add]

  def add
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.update_attribute(:quantity, (cart_item.quantity || 0) + 1)
    cart_item.save
    redirect_to cart_path(@cart)
  end

  def show
    @cart_items = @cart.cart_items
  end

  def remove
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_by(product: product)
    cart_item.destroy if cart_item
    redirect_to cart_path
  end

  def update
    cart_item = @cart.cart_items.find(params[:cart_item_id])
    if cart_item.update(cart_item_params)
      redirect_to cart_path
    else
      render :show
    end
  end

  def checkout
    @cart = current_customer.cart
    @customer = current_customer
  end

  def place_order
    @cart = current_customer.cart

    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty. Please add items before proceeding."
    else
      puts "Order Confirmed! Thank you for shopping with us!"

      redirect_to order_confirmed_path, notice: "Your order has been confirmed! Thank you for shopping with us."
    end
  end

  private

  def set_cart
    @cart = current_customer ? current_customer.cart || current_customer.create_cart(status: 'active') : Cart.create(status: 'active')
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end