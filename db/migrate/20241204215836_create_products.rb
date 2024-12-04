class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :product_name
      t.text :description
      t.decimal :price
      t.string :size
      t.string :colour

      t.timestamps
    end
  end
end
