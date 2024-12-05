class ApplicationController < ActionController::Base
  helper_method :current_customer, :logged_in?, :current_cart

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

  def logged_in?
    current_customer.present?
  end

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