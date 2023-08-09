# frozen_string_literal: true

class RenameQuantityColumnInStockAdjustments < ActiveRecord::Migration[7.0]
  def change
    rename_column :stock_adjustments, :quantity, :quantity_diff
  end
end
