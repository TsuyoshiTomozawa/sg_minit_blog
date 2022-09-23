class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true,
            length: { maximum: 20 },
            uniqueness: true,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: "アルファベットのみが使えます" }
  validates :profile, length: { maximum: 200 }
  validates :blog_url,
            format: /\A#{URI::regexp(%w(http https))}\z/,
            allow_nil: true

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
