require 'rails_helper'

RSpec.describe StockAdjustmentForm, type: :model do
  describe '#save' do
    let(:user) { create(:user) }
    let(:stock) { create(:stock, quantity: 10) }
    let(:valid_attributes) do
      {
        stock_adjustment_form: {
          quantity: 15,
          reason: StockAdjustment::REASONS.sample,
          note: 'Adjustment note'
        }
      }
    end

    context 'with valid attributes' do
      it 'creates a new stock adjustment and updates stock quantity' do
        form = StockAdjustmentForm.new(user, stock, valid_attributes)

        expect { form.save }.to change(StockAdjustment, :count).by(1)
        expect(stock.reload.quantity).to eq(15)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          stock_adjustment_form: {
            quantity: nil,
            reason: 'invalid_reason',
            note: ''
          }
        }
      end

      it 'does not create a stock adjustment' do
        form = StockAdjustmentForm.new(user, stock, invalid_attributes)

        expect { form.save }.not_to change(StockAdjustment, :count)
        expect(form).not_to be_valid
      end
    end
  end
end
