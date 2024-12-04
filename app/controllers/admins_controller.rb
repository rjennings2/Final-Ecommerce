class AdminsController < ApplicationController
  before_action :require_admin

  def dashboard
  end

  private

  def require_admin
    redirect_to admin_login_path, alert: 'Access denied!' unless session[:admin_id]
  end
end