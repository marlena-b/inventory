class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :location

  validates :quantity, presence: true

  scope :ordered_by_product_name, -> { includes(:product).order('products.name') }
end
