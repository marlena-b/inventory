# frozen_string_literal: true

module ProductsHelper
  def total_quantity_of_products(product)
    total_quantity = []
    product.stocks.each do |stock|
      total_quantity << stock.quantity
    end
    total_quantity.sum
  end
end
