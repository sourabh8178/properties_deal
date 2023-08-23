class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :user_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
