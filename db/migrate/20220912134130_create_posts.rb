class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :content, null: false, limit: 140
      t.timestamps
    end
  end

end
