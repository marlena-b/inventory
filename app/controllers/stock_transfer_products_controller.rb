# frozen_string_literal: true

class StockTransferProductsController < ApplicationController
  def update_bulk
    params[:stock_transfer_products].each do |id, stock_transfer_product_params|
      @stock_transfer_product = StockTransferProduct.find(id)
      @stock_transfer_product.update(quantity: stock_transfer_product_params[:quantity])
    end
    redirect_to add_transfer_products_new_url(@stock_transfer_product.stock_transfer)
  end

  def destroy
    stock_transfer_product = StockTransferProduct.find(params[:id])
    stock_transfer_product.destroy
    redirect_to stock_transfer_product.stock_transfer
  end
end
