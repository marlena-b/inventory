class StockAdjustment < ApplicationRecord
  belongs_to :user
  belongs_to :location
  belongs_to :product
end
