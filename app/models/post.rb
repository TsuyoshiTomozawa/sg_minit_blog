class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  scope :recent, -> { order(created_at: :desc) }
  scope :timeline, -> (filter:, current_user:) { where(user_id: [current_user.id, *current_user.following_ids]) if filter == :following }


end
