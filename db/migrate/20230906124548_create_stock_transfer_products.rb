# frozen_string_literal: true

class CreateStockTransferProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_transfer_products do |t|
      t.references :product, foreign_key: true, null: false
      t.references :stock_transfer, foreign_key: true, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
