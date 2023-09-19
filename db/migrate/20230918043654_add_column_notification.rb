class AddColumnNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :url, :string
    change_column :notifications, :status, :string, default: "unread"
  end
end
