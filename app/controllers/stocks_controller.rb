# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :authenticate_user!

  def update
    @stock = Stock.find(params[:id])
    @stock.update!(stock_params)

    redirect_back_or_to @stock.product
  end

  def edit_transfer
    @product = Product.find(params[:id])
  end

  def transfer
    @product = Product.find(params[:id])
    TransferStockService.new(product: @product, source_location: params[:stocks][:source_location_id], destination_location: params[:stocks][:destination_location_id], quantity: params[:stocks][:quantity]).call
    redirect_to @product
  end

  private

  def stock_params
    params.require(:stock).permit(:quantity)
  end
end
