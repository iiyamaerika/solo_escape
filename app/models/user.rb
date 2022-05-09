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
  
  has_many :weights

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
    users_gender_seclet: 0,
    users_gender_man: 1,
    users_gender_woman: 2,
    users_gender_non_binary: 3
  }, _prefix: true

  enum age: {
    users_age_seclet: 0,
    users_age_early_20s: 1,
    users_age_late_20s: 2,
    users_age_early_30s: 3,
    users_age_late_30s: 4,
    users_age_early_40s: 5,
    users_age_late_40s: 6
  }, _prefix: true

  enum partner_gender: {
    partners_gender_seclet: 0,
    partners_gender_man: 1,
    partners_gender_woman: 2,
    partners_gender_non_binary: 3
  }, _prefix: true

  enum partner_age: {
    partners_age_seclet: 0,
    partners_age_early_20s: 1,
    partners_age_late_20s: 2,
    partners_age_early_30s: 3,
    partners_age_late_30s: 4,
    partners_age_early_40s: 5,
    partners_age_late_40s: 6
  }, _prefix: true

  enum partner_type: {
    partners_type_unknown: 0,
    partners_type_dog_type: 1,
    partners_type_cat_type: 2,
    partners_type_rabbit_type: 3,
    partners_type_sheep_type: 4,
    partners_type_wolf_type: 5
  }, _prefix: true

  # プロフィール画像がない場合は"no-image-icon.jpg"を表示させる
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_icon.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image_icon.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end
  
  # フォローする時
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外す時
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているのか判定
  def following?(user)
    followings.include?(user)
  end


end
