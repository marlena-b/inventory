# frozen_string_literal: true

class StockTransfersController < ApplicationController
  def index
    @stock_transfers = StockTransfer.all
  end

  def new
    @stock_transfer = StockTransfer.new
  end

  def create
    @stock_transfer = StockTransfer.new(stock_transfer_params)
    if @stock_transfer.save
      redirect_to add_transfer_products_new_path(@stock_transfer)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def add_products_new
    @stock_transfer = StockTransfer.find(params[:id])
    @stock_transfer_stocks_paginated = @stock_transfer.source_location.stocks.page(params[:page]).per(10).order(created_at: :desc)
  end

  def add_products
    @stock_transfer = StockTransfer.find(params[:id])
    @stock_transfer_stocks_paginated = @stock_transfer.source_location.stocks.page(params[:page]).per(10).order(created_at: :desc)
    product_ids = params[:product_ids]
    quantities = params[:quantities] || {}

    product_ids.each do |product_id|
      quantity = quantities[product_id].to_i

      stock_transfer_product = @stock_transfer.stock_transfer_products.find_or_initialize_by(product_id:)
      stock_transfer_product.quantity = quantity
      stock_transfer_product.save!
    end
    redirect_to add_transfer_products_new_url(@stock_transfer)
  end

  private

  def stock_transfer_params
    params.require(:stock_transfer).permit(:destination_location_id, :source_location_id)
  end
end
