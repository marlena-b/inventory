class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :location

  validates :quantity, presence: true
end
