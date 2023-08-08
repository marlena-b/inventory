# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdjustStockService do
  describe '#call' do
    let(:stock) { create(:stock, quantity: 40) }
    let(:user) { create(:user) }

    it 'updates stock quantity' do
      AdjustStockService.new(
        user:, stock:, reason: 'new stock', quantity_after_adjustment: 100
      ).call

      expect(stock.quantity).to eq(100)
    end

    it 'creates Stock Adjustment' do
      AdjustStockService.new(
        user:, stock:, reason: 'new stock', quantity_after_adjustment: 100
      ).call

      stock_adjustment = StockAdjustment.find_by!(product: stock.product, location: stock.location)

      expect(stock_adjustment.quantity_diff).to eq(60)
      expect(stock_adjustment.quantity_after_adjustment).to eq(100)
      expect(stock_adjustment.reason).to eq('new stock')
      expect(stock_adjustment.note).to eq(nil)
    end
  end
end
