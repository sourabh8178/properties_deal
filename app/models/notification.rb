class Notification < ApplicationRecord
	scope :unread, -> { where status: "unread" }
	belongs_to :user
	after_create_commit {broadcast_append_to "notifications"}
end
