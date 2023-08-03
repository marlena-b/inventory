# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.new
    Location.all.each { |location| @product.stocks.build(location:, quantity: 0) }
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
    @products = Product.all.order(updated_at: :desc).includes(:category, :stocks, image_attachment: :blob)
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_url, status: :see_other
  end

  def edit_transfer
    @product = Product.find(params[:id])
  end

  def transfer
    @product = Product.find(params[:id])
    TransferProductFromStockService.new(product: @product, location: params[:stocks][:location_id], second_location: params[:stocks][:second_location_id], quantity: params[:stocks][:quantity]).call
    redirect_to @product
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :sku, :image, :category_id,
                                    stocks_attributes: %i[quantity location_id id])
  end
end
