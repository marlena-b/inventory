# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :authenticate_user!

  def update
    @stock = Stock.find(params[:id])
    @stock.update!(stock_params)

    redirect_back_or_to @stock.product
  end

  private

  def stock_params
    params.require(:stock).permit(:quantity)
  end
end
