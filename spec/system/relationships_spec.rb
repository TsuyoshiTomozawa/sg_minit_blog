require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  before do
    @user = FactoryBot.create(:user, name: "user")
    @other = FactoryBot.create(:user, name: "other")
    @another = FactoryBot.create(:user, name: "another")
    @post1 = FactoryBot.create(:post, user: @other)
    @post2 = FactoryBot.create(:post, user: @another)
    @mypost = FactoryBot.create(:post, user: @user)
  end

  describe "フォローとアンフォロー" do
    it 'ユーザーをフォロー、フォロー解除できること' do
      sign_in_as(@user)
      expect(@user.following.size).to eq 0
      expect(@other.followers.size).to eq 0
      expect(find("#post-#{@post1.id} input[name='commit']").value).to eq "フォロー"

      # フォロー
      find("#post-#{@post1.id} input[name='commit']").click
      expect(@user.reload.following.size).to eq 1
      expect(@other.reload.followers.size).to eq 1
      expect(find("#post-#{@post1.id} input[name='commit']").value).to eq "アンフォロー"

      # アンフォロー
      find("#post-#{@post1.id} input[name='commit']").click
      expect(@user.reload.following.size).to eq 0
      expect(@other.reload.followers.size).to eq 0
      expect(find("#post-#{@post1.id} input[name='commit']").value).to eq "フォロー"
    end
  end

  describe "タイムライン" do
    before do
      sign_in_as(@user)
      find("#post-#{@post1.id} input[name='commit']").click
    end

    context 'パラメータなし' do
      before do
        visit root_path
      end

      it 'フォローボタン表示' do
        expect(find("#post-#{@post2.id} input[name='commit']").value).to eq "フォロー"
      end

      it 'アンフォローボタン表示' do
        expect(find("#post-#{@post1.id} input[name='commit']").value).to eq "アンフォロー"
      end

      it '自分の投稿にはフォローボタンがないことの確認' do
        expect(has_field?("#post-#{@mypost.id} input[name='commit']")).to be_falsey
      end
    end

    context 'パラメータあり' do
      it 'すべて表示' do

      end

      it 'フォローしたユーザーの投稿のみ表示' do

      end
    end
  end
end
