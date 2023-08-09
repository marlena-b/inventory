# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :authenticate_user!

  # rubocop:disable Metrics/AbcSize
  def update
    stock = Stock.find(params[:id])
    AdjustStockService.new(
      user: current_user,
      stock:,
      quantity_after_adjustment: params[:stock][:quantity],
      reason: params[:stock][:reason],
      note: params[:stock][:note].presence
    ).call
    redirect_back_or_to stock.product
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
