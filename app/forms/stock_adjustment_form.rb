# frozen_string_literal: true

class StockAdjustmentForm
  include ActiveModel::Model

  attr_accessor :quantity, :reason, :note

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :reason, presence: true, inclusion: { in: StockAdjustment::REASONS }
  validates :note, presence: true, length: { maximum: 255 }

  def initialize(user, stock, params = {})
    @user = user
    @stock = stock
    @quantity = params.dig(:stock_adjustment_form, :quantity) || @stock.quantity
    @reason = params.dig(:stock_adjustment_form, :reason)
    @note = params.dig(:stock_adjustment_form, :note)
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      StockAdjustment.create!(stock_adjustment_params)
      @stock.update!(quantity: @quantity)
    end
  end

  private

  def stock_adjustment_params
    {
      user: @user,
      location: @stock.location,
      product: @stock.product,
      quantity_diff: @quantity.to_i - @stock.quantity,
      quantity_after_adjustment: @quantity,
      reason: @reason,
      note: @note
    }
  end
end
