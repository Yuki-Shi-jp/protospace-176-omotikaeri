class Prototype < ApplicationRecord
  # バリデーション
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

  # アソシエーション
  has_many :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
end
