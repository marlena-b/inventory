class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, presence: true
end
