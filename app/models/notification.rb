class Notification < ApplicationRecord
	after_create_commit {broadcast_append_to "notifications"}
end
