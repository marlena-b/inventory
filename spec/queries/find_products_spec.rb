# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FindProducts do
  describe '#call' do
    it 'searches by low level' do
      product1 = create(:product)
      _product2 = create(:product)
      _stock = create(:stock, product: product1, low_level: 10, quantity: 5)

      result = FindProducts.new(low_level: '1').call
      expect(result).to eq([product1])
    end

    it 'searches by category' do
      category1 = create(:category)
      category2 = create(:category)

      product1 = create(:product, category: category1)
      _product2 = create(:product, category: category2)

      result = FindProducts.new(category_id: category1.id).call

      expect(result).to eq([product1])
    end

    it 'searches by search_term' do
      product1 = create(:product, name: 'Product')
      _product2 = create(:product, name: 'Shoes')
      product3 = create(:product, sku: 'xod-123')

      result = FindProducts.new(search_term: 'od').call

      expect(result).to match_array([product1, product3])
    end

    it 'searches by category and search_term' do
      category1 = create(:category)
      category2 = create(:category)

      product1 = create(:product, name: 'Product', category: category1)
      _product2 = create(:product, sku: 'xod-123', category: category2)
      _product3 = create(:product, name: 'Shoe', category: category1)

      result = FindProducts.new(category_id: category1.id, search_term: 'od').call

      expect(result).to eq([product1])
    end

    it 'returns products ordered by updated at' do
      product1 = create(:product, updated_at: 3.days.ago)
      product2 = create(:product, updated_at: 2.days.ago)
      product3 = create(:product, updated_at: 1.day.ago)

      result = FindProducts.new({}).call

      expect(result).to eq([product3, product2, product1])
    end

    context 'with blank category_id' do
      it 'returns all' do
        category1 = create(:category)
        category2 = create(:category)

        product1 = create(:product, category: category1)
        product2 = create(:product, category: category2)
        product3 = create(:product, category: nil)

        result = FindProducts.new(category_id: '').call

        expect(result).to match_array([product1, product2, product3])
      end
    end

    context 'with blank search_term' do
      it 'returns all' do
        product1 = create(:product, name: 'Product')
        product2 = create(:product, name: 'Shoes')
        product3 = create(:product, sku: 'xod-123')

        result = FindProducts.new(search_term: '').call

        expect(result).to match_array([product1, product2, product3])
      end
    end
  end
end
