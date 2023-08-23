class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :agents, -> { where role: "agent" }
  scope :customers, -> { where role: "customer" }
  has_one :profile, dependent: :destroy
  has_many :properties, dependent: :destroy

  has_many :messages
  has_many :feedbacks
end
