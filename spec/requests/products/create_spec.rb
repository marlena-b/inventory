# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /products', type: :request do
  context 'with logged in user' do
    let(:location) { create(:location) }
    let(:user) { create(:user) }
    before { sign_in user }

    context 'with valid parameters' do
      let(:valid_attributes) do
        { name: 'Product', description: 'Very good product', sku: 154_689,
          stocks_attributes: { 0 => { location_id: location.id, quantity: 2, low_level: 1 } } }
      end
      it 'creates a new product' do
        expect do
          post products_url, params: { product: valid_attributes }
        end.to change(Product, :count).by(1)
      end

      it 'sets up stocks' do
        post products_url, params: { product: valid_attributes }
        product = Product.last
        expect(product.stocks.count).to eq(1)
        stock = product.stocks.first
        expect(stock.quantity).to eq(2)
        expect(stock.low_level).to eq(1)
      end

      it 'redirects to the created product' do
        post products_url, params: { product: valid_attributes }
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { name: nil, stocks_attributes: { 0 => { location_id: location.id, quantity: 2, low_level: 1 } } }
      end
      it 'does not create a new product' do
        expect do
          post products_url, params: { product: invalid_attributes }
        end.to change(Product, :count).by(0)
      end

      it "renders 'new' template" do
        post products_url, params: { product: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
