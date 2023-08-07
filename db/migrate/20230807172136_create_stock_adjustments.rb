class CreateStockAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_adjustments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true, index: true
      t.integer :quantity, null: false
      t.integer :quantity_after_adjustment, null: false
      t.string :reason, null: false
      t.text :note

      t.timestamps
    end
  end
end
