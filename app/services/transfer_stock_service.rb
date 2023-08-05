# frozen_string_literal: true

class TransferStockService
  def initialize(product:, source_location:, destination_location:, quantity:)
    @product = product
    @source_location = source_location
    @destination_location = destination_location
    @quantity = quantity.to_i
  end

  def call
    ActiveRecord::Base.transaction do
      stock1 = @product.stocks.find_by!(location: @source_location)
      stock1.quantity -= @quantity
      stock1.save
      stock2 = @product.stocks.find_by!(location: @destination_location)
      stock2.quantity += @quantity
      stock2.save
    end
  end
end
