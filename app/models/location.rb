# frozen_string_literal: true

class Location < ApplicationRecord
  include ImageValidation

  has_one_attached :image
  has_many :stocks, dependent: :destroy
  has_many :stock_transfers, dependent: :destroy

  validates :name, presence: true

  validate :acceptable_image
end
