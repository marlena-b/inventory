class TransferProductFromStockService
  def initialize(product:, location:, second_location:, quantity:)
    @product = product
    @location = location
    @second_location = second_location
    @quantity = quantity.to_i
  end

  def call
    @stock_1 = Stock.find_by(location: @location, product: @product)
    @stock_1.quantity -=  @quantity
    @stock_1.save
    @stock_2 = Stock.find_by(location: @second_location, product: @product)
    @stock_2.quantity += @quantity
    @stock_2.save
  end
end
