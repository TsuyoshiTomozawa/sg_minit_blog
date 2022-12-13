class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true,
            length: { maximum: 20 },
            uniqueness: true,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: "はアルファベットのみが使えます" }
  validates :profile, length: { maximum: 200 }, allow_blank: true
  validates :blog_url,
            format: /\A#{URI::regexp(%w(http https))}\z/,
            allow_blank: true

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
