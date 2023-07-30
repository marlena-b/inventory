# frozen_string_literal: true

require 'faker'

5.times do |i|
  User.create!(
    email: "john#{i}@example.com",
    password: 'password',
    name: Faker::Name.name
  )
end

categories = Category.create!([{ name: 'Rurki' }, { name: 'Stelaże' }, { name: 'Stojaki' }, { name: 'Śrubki' }])

30.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    sku: Faker::Number.number(digits: 10),
    category: categories.sample
  )
end

3.times do
  Location.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address
  )
end

Location.all.each do |location|
  Product.all.each do |product|
    Stock.create!(
      product:,
      location:,
      quantity: Faker::Number.number(digits: 2)
    )
  end
end
