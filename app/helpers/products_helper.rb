# frozen_string_literal: true

module ProductsHelper
  def format_quantity_adjustment(quantity)
   return "+#{quantity}" if quantity.positive?
    quantity.to_s
  end
end
