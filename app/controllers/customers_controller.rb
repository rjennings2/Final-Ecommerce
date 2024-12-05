class CustomersController < ApplicationController
  def new
    @customer = Customer.new  # Initialize a new customer object for the form
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      # If successful, redirect to the home page or a dashboard
      redirect_to root_path, notice: 'Account created successfully!'
    else
      # If there are errors, re-render the signup form
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:username, :password, :password_confirmation)
  end
end