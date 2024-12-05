class ProductsController < ApplicationController
  def index
    @products = Product.all
    # @cart = current_cart

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

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :category_id, images: [])
  end
end