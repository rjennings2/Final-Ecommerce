class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:username, :password, :password_confirmation, :city, :street, :house_number, :province_id)
  end
end