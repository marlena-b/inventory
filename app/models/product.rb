class Product < ApplicationRecord
  include ImageValidation

  has_one_attached :image

  validates :name, presence: true

  validate :acceptable_image

end
