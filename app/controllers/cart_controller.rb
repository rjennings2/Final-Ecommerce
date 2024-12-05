class CartController < ApplicationController
  def show
    @cart = current_cart
    @products = Product.where(id: @cart.map { |item| item[:product_id] })
  end

  def checkout
    @cart = current_cart
    @order = Order.new
  end

  def place_order
    @cart = current_cart
    @order = Order.new(order_params)
    @order.customer = current_customer
    @order.total_price = calculate_total_price(@cart)

    @cart.each do |item|
      @order.order_items.build(
        product_id: item[:product_id],
        quantity: item[:quantity],
        price: Product.find(item[:product_id]).price
      )
    end

    if @order.save
      session[:cart] = []
      redirect_to order_path(@order), notice: "Your order has been placed successfully!"
    else
      render :checkout, alert: "There was an issue placing your order."
    end
  end

  private

  def order_params
    params.require(:order).permit(:shipping_address, :status)
  end

  def calculate_total_price(cart)
    cart.sum { |item| Product.find(item[:product_id]).price * item[:quantity] }
  end

  def add
    product = Product.find(params[:product_id])
    add_to_cart(product.id)
    redirect_to cart_path, notice: "#{product.product_name} was added to your cart!"
  end

  def remove
    product = Product.find(params[:product_id])
    remove_from_cart(product.id)
    redirect_to cart_path, notice: "#{product.product_name} was removed from your cart!"
  end

  def update
    product = Product.find(params[:product_id])
    update_cart(product.id, params[:quantity])
    redirect_to cart_path, notice: "Cart updated!"
  end

  private

  def current_cart
    session[:cart] ||= []
  end

  def add_to_cart(product_id)
    cart = current_cart
    existing_item = cart.find { |item| item[:product_id] == product_id }

    if existing_item
      existing_item[:quantity] += 1
    else
      cart << { product_id: product_id, quantity: 1 }
    end
    session[:cart] = cart
  end

  def remove_from_cart(product_id)
    cart = current_cart
    cart.reject! { |item| item[:product_id] == product_id }
    session[:cart] = cart
  end

  def update_cart(product_id, quantity)
    cart = current_cart
    item = cart.find { |item| item[:product_id] == product_id }
    if item
      item[:quantity] = quantity.to_i
      session[:cart] = cart
    end
  end
end