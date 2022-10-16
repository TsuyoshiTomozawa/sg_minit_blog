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

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
