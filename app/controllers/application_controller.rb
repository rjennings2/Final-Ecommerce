class ApplicationController < ActionController::Base
<<<<<<< HEAD
  helper_method :current_customer, :logged_in?

  def current_customer
    @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end

  def logged_in?
    current_customer.present?
=======
  helper_method :current_cart

  # Access the current cart stored in the session
  def current_cart
    session[:cart] ||= []  # Initialize an empty array if no cart exists
  end

  def add_to_cart(product_id)
    cart = current_cart
    existing_item = cart.find { |item| item[:product_id] == product_id }

    if existing_item
      existing_item[:quantity] += 1  # Increment quantity if the item already exists
    else
      cart << { product_id: product_id, quantity: 1 }  # Add new item with quantity
    end
    session[:cart] = cart  # Ensure the session cart is updated

    # Log the current cart content after adding the product
    Rails.logger.debug "Cart after adding: #{session[:cart]}"
  end

  # Remove a product from the cart
  def remove_from_cart(product_id)
    cart = current_cart
    cart.reject! { |item| item[:product_id] == product_id }
    session[:cart] = cart
  end

  # Update the quantity of a product in the cart
  def update_cart(product_id, quantity)
    cart = current_cart
    item = cart.find { |item| item[:product_id] == product_id }
    if item
      item[:quantity] = quantity.to_i
      session[:cart] = cart  # Ensure the session cart is updated
    end
>>>>>>> cart-and-checkout
  end
end