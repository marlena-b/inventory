# frozen_string_literal: true

class TransferStockService
  def initialize(product:, source_location:, destination_location:, quantity:, current_user:)
    @product = product
    @source_location = source_location
    @destination_location = destination_location
    @quantity = quantity.to_i
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      stock1 = @product.stocks.find_by!(location: @source_location)
      AdjustStockService.new(user: @current_user, stock: stock1, quantity_after_adjustment: stock1.quantity - @quantity, reason: 'transfer').call
      stock2 = @product.stocks.find_by!(location: @destination_location)
      AdjustStockService.new(user: @current_user, stock: stock2, quantity_after_adjustment: stock2.quantity + @quantity, reason: 'transfer').call
    end
  end
end
