class AddColumnNameToNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :name, :string, default: "welcome"
  end
end
