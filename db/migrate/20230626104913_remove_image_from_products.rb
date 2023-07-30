# frozen_string_literal: true

class RemoveImageFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :image, :string
  end
end
