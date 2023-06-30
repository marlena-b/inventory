class CreateStock < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :location, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
