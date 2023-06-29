require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "validations" do
    it "is not valid without name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is valid with name" do
      expect(subject).to be_valid
    end
  end

  describe "deleting" do
    subject { described_class.create!(name: "Rurki") }
    let!(:product) { Product.create!(name: "Rurka", category: subject) }

    it "nullifies associated products category_ids" do
      subject.destroy!
      product.reload
      expect(product.category_id).to be_nil
    end
  end
end
