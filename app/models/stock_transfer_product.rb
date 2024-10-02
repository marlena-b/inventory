# frozen_string_literal: true

class StockTransferProduct < ApplicationRecord
  belongs_to :product
  belongs_to :stock_transfer
end
