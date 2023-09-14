class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :payment_id
      t.float :amount
      t.string :payment_method
      t.float :amount_refund
      t.string :refund_status
      t.string :order_email
      t.string :order_mobile
      t.string :product_sale
      t.string :upi_transaction_id
      t.string :upi_id
      t.string :time_at
      t.string :status
      t.string :refresence_id
      t.integer :user_id

      t.timestamps
    end
  end
end
