# frozen_string_literal: true

class StockAdjustment < ApplicationRecord
  REASONS = ['new stock', 'transfer', 'adjustment', 'damaged', 'lost', 'other'].freeze
  belongs_to :user
  belongs_to :location
  belongs_to :product
end
