class Admin::ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Product created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  def show

  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:category_id, :product_name, :description, :price, :size, :colour)
  end
end
