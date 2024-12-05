class AddAddressFieldsToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :city, :string
    add_column :customers, :street, :string
    add_column :customers, :house_number, :string
    add_column :customers, :province, :string
  end
end
