# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    product
    location
    quantity { 45 }
  end
end
