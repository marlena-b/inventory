# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John' }
    email { 'john@example.com' }
    password { 'password' }
  end
end
