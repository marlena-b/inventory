# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'DELETE /products/:id', type: :request do
  context 'with logged in user' do
    let!(:product) { create(:product) }
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
