# frozen_string_literal: true

class Product < ApplicationRecord
  include ImageValidation

  belongs_to :category, optional: true
  has_many :stocks, inverse_of: :product, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validate :acceptable_image

  accepts_nested_attributes_for :stocks
end
