# frozen_string_literal: true

class CreateStockTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_transfers do |t|
      t.references :source_location, foreign_key: { to_table: :locations }, null: false
      t.references :destination_location, foreign_key: { to_table: :locations }, null: false

      t.timestamps
    end
  end
end
