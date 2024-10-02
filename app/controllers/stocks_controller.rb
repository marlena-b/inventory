# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :authenticate_user!

  def edit
    @stock = Stock.find(params[:id])
    @stock_adjustment_form = StockAdjustmentForm.new(current_user, @stock)
  end

  def update
    @stock = Stock.find(params[:id])
    @stock_adjustment_form = StockAdjustmentForm.new(current_user, @stock, params)
    if @stock_adjustment_form.save
      redirect_to @stock.product, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # rubocop:enable Metrics/AbcSize
  def transfer
    product = Product.find(params[:id])
    TransferStockService.new(
      product:,
      source_location: params[:stocks][:source_location_id],
      destination_location: params[:stocks][:destination_location_id],
      quantity: params[:stocks][:quantity],
      current_user:
    ).call
    redirect_to product
  end

  private

  def stock_params
    params.require(:stock).permit(:quantity)
  end
end
