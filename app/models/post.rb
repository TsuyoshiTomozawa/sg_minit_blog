class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }

  scope :recent, -> { order(created_at: :desc) }

end
