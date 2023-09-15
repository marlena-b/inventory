# frozen_string_literal: true

class StockTransfer < ApplicationRecord
  belongs_to :source_location, class_name: 'Location'
  belongs_to :destination_location, class_name: 'Location'
  has_many :stock_transfer_products
  has_many :products, through: :stock_transfer_products

  validate :ensure_different_source_and_destination

  private

  def ensure_different_source_and_destination
    return unless source_location == destination_location

    errors.add(:destination_location, "can't be the same as the source location")
  end
end
