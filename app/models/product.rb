class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
end
