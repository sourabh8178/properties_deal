class CreateSubPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_plans do |t|
      t.string :limit
      t.float :amount
      t.string :sub_type
      t.integer :user_id
      t.string :status, default: "activate"

      t.timestamps
    end
  end
end
