class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trails, dependent: :destroy
  has_one_attached :photo
end
