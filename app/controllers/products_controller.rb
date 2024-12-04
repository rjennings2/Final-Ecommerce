class ProductsController < ApplicationController
  def index
    @products = Product.all

    # Apply filters if provided
    if params[:on_sale].present?
      @products = @products.where(on_sale: params[:on_sale])
    end

    if params[:is_new].present?
      @products = @products.where(is_new: params[:is_new])
    end

    if params[:recently_updated].present?
      @products = @products.where("updated_at > ?", 1.month.ago)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
