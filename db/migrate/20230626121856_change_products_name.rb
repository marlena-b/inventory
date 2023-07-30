# frozen_string_literal: true

class ChangeProductsName < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:products, :name, false, 'Untitled')
  end
end
