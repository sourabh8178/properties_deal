class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.float :price
      t.float :size
      t.text :amenities
      t.string :location
      t.string :property_type
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :parking
      t.boolean :is_approved, default: false
      t.integer :user_id
      t.integer :status_type

      t.timestamps
    end
  end
end
