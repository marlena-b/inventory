# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /products/:id', type: :request do
  context 'with logged in user' do
    let(:user) { create(:user) }
    before { sign_in user }

    it 'renders show view' do
      product = create(:product)
      get product_url(product)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'responds with 404 when product not found' do
      expect { get product_url(88) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'without logged in user' do
    it 'redirects to login page' do
      product = create(:product)
      get product_url(product)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
