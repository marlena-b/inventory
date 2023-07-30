# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe 'validations' do
    it 'is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with name' do
      expect(subject).to be_valid
    end
  end

  describe 'deleting' do
    subject { create(:category) }
    let!(:product) { create(:product, category: subject) }

    it 'nullifies associated products category_ids' do
      subject.destroy!
      product.reload
      expect(product.category_id).to be_nil
    end
  end
end
