class AddFiltersToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :on_sale, :boolean
    add_column :products, :is_new, :boolean
  end
end
