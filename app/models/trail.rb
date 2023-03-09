class Trail < ApplicationRecord
  belongs_to :user
  has_many :content_video, dependent: :destroy
  validates :category, presence: true
end
