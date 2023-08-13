# frozen_string_literal: true

class AddLowLevelToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :low_level, :integer
  end
end
