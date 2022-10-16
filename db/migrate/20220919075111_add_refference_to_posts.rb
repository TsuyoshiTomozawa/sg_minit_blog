class AddRefferenceToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, after: :content, foreign_key: true, null: false
  end
end
