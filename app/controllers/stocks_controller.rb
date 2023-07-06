class StocksController < ApplicationController

  def update
    @stock = Stock.find_by(location: params[:stock][:location_id], product: params[:stock][:product_id])
    @stock.update!(stock_params)

    redirect_to @stock.location
  end


  private
  def stock_params
    params.require(:stock).permit(:quantity)
  end
end
