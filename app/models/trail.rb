class Trail < ApplicationRecord
  belongs_to :user
  has_many :video_contents, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_one_attached :photo
  CATEGORIES = ["Culture", "Entertainment", "Fashion", "Gastronomy", "Music", "Nature", "Phylosophy", "Self-Care", "Sports", "Technology", "Others"]
  validates :category, presence: true, inclusion: { in: CATEGORIES.map { |category| category.capitalize }}
end
