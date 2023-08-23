class Property < ApplicationRecord
	has_many_attached :images
	belongs_to :user, dependent: :destroy
	has_many :feedbacks, dependent: :destroy
	enum status_type: ["For Rent", "For Sale"]
end
