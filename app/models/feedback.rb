class Feedback < ApplicationRecord
	belongs_to :property
	belongs_to :user
	after_create_commit {broadcast_append_to "feedbacks"}
end
