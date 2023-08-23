class AddColumnToFeedback < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :user_id, :integer
  end
end
