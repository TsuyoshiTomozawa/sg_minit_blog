class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  scope :recent, -> { order(created_at: :desc) }

end
