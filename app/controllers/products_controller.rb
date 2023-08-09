# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all.order(updated_at: :desc).includes(:category, :stocks, image_attachment: :blob)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    Location.all.each { |location| @product.stocks.build(location:, quantity: 0) }
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    Location.all.each { |location| @product.stocks.build(location:, quantity: 0) }
    ActiveRecord::Base.transaction do
      if @product.save
        adjust_stock(@product, "new stock")
        redirect_to @product
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    ActiveRecord::Base.transaction do
      if @product.update(product_params)
        adjust_stock(@product, "adjustment")
        redirect_to @product
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_url, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :sku, :image, :category_id)
  end

  def adjust_stock(product, reason)
    params[:product][:stocks_attributes].values.each do |stock_attribute|
      stock = product.stocks.detect { |stock| stock.location_id == stock_attribute[:location_id].to_i }
      if stock_attribute[:quantity].to_i != stock.quantity
        AdjustStockService.new(
          user: current_user,
          stock: stock,
          quantity_after_adjustment: stock_attribute[:quantity].to_i,
          reason: reason).call
      end
    end
  end
end
