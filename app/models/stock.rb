# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :location

  validates :quantity, presence: true

  scope :ordered_by_product_name, -> { includes(:product).order('products.name') }

  def low_stock?
    return false if low_level.blank?

    quantity <= low_level
  end
end
