class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart = current_cart # Ensure @cart is set for the view

    if params[:on_sale].present?
      @products = @products.where(on_sale: params[:on_sale])
    end

    if params[:is_new].present?
      @products = @products.where(is_new: params[:is_new])
    end

    if params[:recently_updated].present?
      @products = @products.where("updated_at > ?", 1.month.ago)
    end

    if params[:category].present?
      @products = @products.where(category_id: Category.find_by(category_name: params[:category])&.id)
    end

    if params[:search].present?
      @products = @products.where("product_name LIKE ?", "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end
end