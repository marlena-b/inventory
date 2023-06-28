class Product < ApplicationRecord
  include ImageValidation

  has_one_attached :image

  belongs_to :category

  validates :name, presence: true

  validate :acceptable_image

end
