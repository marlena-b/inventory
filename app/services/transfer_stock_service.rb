class TransferStockService
  def initialize(product:, source_location:, destination_location:, quantity:)
    @product = product
    @source_location = source_location
    @destination_location = destination_location
    @quantity = quantity.to_i
  end

  def call
    ActiveRecord::Base.transaction do
      stock_1 = @product.stocks.find_by!(location: @source_location)
      stock_1.quantity -=  @quantity
      stock_1.save
      stock_2 = @product.stocks.find_by!(location: @destination_location)
      stock_2.quantity += @quantity
      stock_2.save
    end
  end
end
