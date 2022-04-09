class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  # バリデーション
  validates :status, presence: true
  validates :text, presence: true, length: {maximum: 120}
  
  #enumで管理するもの
  enum status: {
    public: 0,
    private: 1
  }
  
end
