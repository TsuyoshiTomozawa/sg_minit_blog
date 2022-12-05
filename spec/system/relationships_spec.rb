require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  before do
    @user = FactoryBot.create(:user, name: "user")
    @other = FactoryBot.create(:user, name: "other")
    @post = FactoryBot.create(:post, user: @other)
  end

  describe "フォローとアンフォロー" do
    it 'ユーザーをフォロー、フォロー解除できること' do
      sign_in_as(@user)
      expect(@user.following.size).to eq 0
      expect(@other.followers.size).to eq 0
      expect(page).to have_button 'フォロー'

      # フォロー
      # find("#post-#{@post.id} #new_relationship input[name='commit']").click
      click_button "フォロー"

      expect(@user.reload.following.size).to eq 1
      expect(@other.reload.followers.size).to eq 1
      expect(page).to have_button 'アンフォロー'

      # アンフォロー
      click_button "アンフォロー"
      expect(@user.reload.following.size).to eq 0
      expect(@other.reload.followers.size).to eq 0
      expect(page).to have_button 'フォロー'
    end
  end

  describe "タイムライン" do
    it 'パラメータなし' do

    end

    context 'パラメータあり' do
      it 'すべて表示' do

      end

      it 'フォローしたユーザーの投稿のみ表示' do

      end
    end
  end
end
