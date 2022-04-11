class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_one_attached :image

  # いいね・コメント機能
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :post_comments, dependent: :destroy

  # 通知機能
  ## 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  ## 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

   # フォロー・フォロワー機能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :name_kana, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :nickname, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  validates :partner_gender, presence: true
  validates :partner_age, presence: true
  validates :partner_type, presence: true
  validates :address, presence: true
  validates :telephone_number, length: { in: 6..11 }

  #enumで管理するもの
  enum gender: {
    seclet: 0,
    man: 1,
    woman: 2,
    non_binary: 3
  }

  enum age: {
    seclet: 0,
    early_20s: 1,
    late_20s: 2,
    early_30s: 3,
    late_30s: 4,
    early_40s: 5,
    late_40s: 6
  }

  enum partner_gender: {
    seclet: 0,
    man: 1,
    woman: 2,
    non_binary: 3
  }

  enum partner_age: {
    seclet: 0,
    early_20s: 1,
    late_20s: 2,
    early_30s: 3,
    late_30s: 4,
    early_40s: 5,
    late_40s: 6
  }

  enum partner_type: {
    unknown: 0,
    dog_type: 1,
    cat_type: 2,
    rabbit_type: 3,
    sheep_type: 4,
    wolf_type: 5
  }

end
