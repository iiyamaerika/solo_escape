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
    article_public: 0,
    article_private: 1
  }
  
   # 投稿画像がない場合は"no-image-icon.jpg"を表示させる
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image-icon.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image-icon.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end
  
end
