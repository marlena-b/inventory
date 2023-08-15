# frozen_string_literal: true

module ProductsHelper
  def format_quantity_adjustment(quantity)
    return "+#{quantity}" if quantity.positive?

    quantity.to_s
  end

  def stock_warnings(product)
    low_stock_sum = product.stocks.count(&:low_stock?)
    return unless low_stock_sum.positive?

    "<span class='badge text-bg-warning'>
    Low stock in #{low_stock_sum} #{'location'.pluralize(low_stock_sum)}.
    </span>".html_safe
  end
end
