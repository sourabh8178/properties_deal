class AddColumnToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :about, :string
  end
end
