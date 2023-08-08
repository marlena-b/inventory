# frozen_string_literal: true

class AdjustStockService
  def initialize(user:, stock:, quantity_after_adjustment:, reason:, note: nil)
    @user = user
    @stock = stock
    @quantity_diff = quantity_after_adjustment.to_i - @stock.quantity
    @quantity_after_adjustment = quantity_after_adjustment
    @reason = reason
    @note = note
  end

  def call
    ActiveRecord::Base.transaction do
      update_stock_quantity
      create_stock_adjustment
    end
  end

  def update_stock_quantity
    @stock.update!(quantity: @quantity_after_adjustment)
  end

  def create_stock_adjustment
    StockAdjustment.create!(
      user: @user,
      location: @stock.location,
      product: @stock.product,
      quantity_diff: @quantity_diff,
      quantity_after_adjustment: @quantity_after_adjustment,
      reason: @reason,
      note: @note
    )
  end
end
