class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by(username: params[:username])
    if customer&.authenticate(params[:password])
      session[:customer_id] = customer.id # Set session to log in
      redirect_to root_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:customer_id] = nil # Log the user out
    redirect_to root_path, notice: "Logged out successfully!"
  end
end