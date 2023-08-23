class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :mobile_number
      t.string :address
      t.boolean :is_complete, default: false

      t.timestamps
    end
  end
end
