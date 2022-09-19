# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: "", limit: 20
      t.string :profile, null: true, default: "", limit: 200
      t.text :blog_url, null: true, default: ""

      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    add_index :users, :name, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
