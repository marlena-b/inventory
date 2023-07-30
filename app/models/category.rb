# frozen_string_literal: true

class Category < ApplicationRecord
  include ImageValidation

  has_many :products, dependent: :nullify
  has_one_attached :image

  validate :acceptable_image
  validates :name, presence: true
end
