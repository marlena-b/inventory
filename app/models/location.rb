class Location < ApplicationRecord
  include ImageValidation

  has_one_attached :image
  has_many :stocks, dependent: :destroy

  validates :name, presence: true

  validate :acceptable_image

end
