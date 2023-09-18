class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :gst, :string
    add_column :orders, :tax, :string
    add_column :orders, :product_amount, :string
    add_column :orders, :product_name, :string
    add_column :orders, :order_type, :string
  end
end
