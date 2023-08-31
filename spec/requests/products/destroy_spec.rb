# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'DELETE /products/:id', type: :request do
  context 'with logged in user' do
    let(:location) { create(:location) }
    let(:valid_attributes) do
      { name: 'Product', description: 'Very good product', sku: 154_689,
        stocks_attributes: { 0 => { location_id: location.id, quantity: 10, low_level: 10 } } }
    end
    let!(:product) { create(:product, valid_attributes) }
    let(:user) { create(:user) }
    before { sign_in user }

    it 'destroys the requested product' do
      expect { delete product_url(product) }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      delete product_url(product)
      expect(response).to redirect_to(products_url)
    end
  end
end
