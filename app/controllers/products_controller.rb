class ProductsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_url, status: :see_other
  end
  private

  def product_params
    params.require(:product).permit(:name, :description, :sku, :image)
  end
end
