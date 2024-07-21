class User < ApplicationRecord
  # バリデーション
  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true
  
  # deviseの使用
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #  アソシエーション
  has_many :prototype
end
