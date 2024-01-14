class ProductDecorator < ApplicationDecorator
  delegate_all

  def self.collection_decorator_class
    PaginationDecorator
  end

  def stock_warnings
    low_stock_sum = product.stocks.count(&:low_stock?)
    return unless low_stock_sum.positive?

    "<span class='badge text-bg-warning'>
    Low stock in #{low_stock_sum} #{'location'.pluralize(low_stock_sum)}.
    </span>".html_safe
  end
end
