class Product < ApplicationRecord
  include ImageValidation

  has_one_attached :image
  has_many :stocks

  belongs_to :category, optional: true

  validates :name, presence: true

  validate :acceptable_image

end
