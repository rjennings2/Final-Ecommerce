class AdminSessionsController < ApplicationController
  def new
    # Renders login form
  end

  def create
    admin = Admin.find_by(username: params[:username])
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_dashboard_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_login_path, notice: 'Logged out successfully!'
  end
end