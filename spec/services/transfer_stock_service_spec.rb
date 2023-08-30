# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransferStockService do
  describe '#call' do
    let(:product) { create(:product) }
    let(:source_location) { create(:location) }
    let(:destination_location) { create(:location) }
    let!(:stock1) { create(:stock, product:, quantity: 40, location: source_location) }
    let!(:stock2) { create(:stock, product:, quantity: 40, location: destination_location) }
    let(:user) { create(:user) }

    it 'adds quantity to destination location' do
      TransferStockService.new(
        product:, source_location:, destination_location:, quantity: 20, current_user: user
      ).call

      expect(stock2.reload.quantity).to eq(60)
    end

    it 'subtracts quantity from source location' do
      TransferStockService.new(
        product:, source_location:, destination_location:, quantity: 20, current_user: user
      ).call

      expect(stock1.reload.quantity).to eq(20)
    end
  end
end
