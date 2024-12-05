class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      session[:customer_id] = @customer.id # Log the user in by setting session
      redirect_to root_path, notice: "Account created successfully!"
    else
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:username, :password, :password_confirmation)
  end
end