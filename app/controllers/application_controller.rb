class ApplicationController < ActionController::Base
  helper_method :current_customer, :logged_in?, :current_cart

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

  def logged_in?
    current_customer.present?
  end

   # Get the current cart stored in the session
   def current_cart
    session[:cart] ||= []  # If no cart exists, initialize it as an empty array
  end

  # Add a product to the cart
  def add_to_cart(product_id)
    cart = current_cart
    existing_item = cart.find { |item| item[:product_id] == product_id }

    if existing_item
      existing_item[:quantity] += 1  # Increase the quantity of the existing item
    else
      cart << { product_id: product_id, quantity: 1 }  # Add a new product with quantity 1
    end
    session[:cart] = cart  # Ensure the session cart is updated
  end

  # Remove a product from the cart
  def remove_from_cart(product_id)
    cart = current_cart
    cart.reject! { |item| item[:product_id] == product_id }  # Remove item by product ID
    session[:cart] = cart
  end

  # Update the quantity of a product in the cart
  def update_cart(product_id, quantity)
    cart = current_cart
    item = cart.find { |item| item[:product_id] == product_id }
    if item
      item[:quantity] = quantity.to_i
      session[:cart] = cart
    end
  end
end