# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH /products/:id', type: :request do
  context 'with logged in user' do
    let(:location) { create(:location) }
    let(:valid_attributes) do
      { name: 'Product', description: 'Very good product', sku: 154_689,
        stocks_attributes: { 0 => { location_id: location.id, quantity: 10, low_level: 10 } } }
    end
    let!(:product) { create(:product, valid_attributes) }
    let(:user) { create(:user) }
    before { sign_in user }

    context 'with valid parameters' do
      let(:new_valid_attributes) do
        { name: 'Shoe', description: 'Very good shoe', sku: 456,
          stocks_attributes: { 0 => { location_id: location.id, quantity: 20, low_level: 20 } } }
      end

      it 'updates requested product' do
        patch product_url(product), params: { product: new_valid_attributes }
        product.reload
        expect(product.attributes).to include('name' => 'Shoe', 'description' => 'Very good shoe', 'sku' => '456')
      end

      it "updates requested product's stock" do
        patch product_url(product), params: { product: new_valid_attributes }
        product.reload
        stock = product.stocks.last
        expect(stock.attributes).to include('quantity' => 20, 'low_level' => 20)
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) do
          { name: nil, stocks_attributes: { 0 => { location_id: location.id, quantity: 2, low_level: 1 } } }
        end

        it "renders 'edit' template" do
          product = Product.create!(valid_attributes)
          patch product_url(product), params: { product: invalid_attributes }
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
