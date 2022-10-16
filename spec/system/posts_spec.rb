require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

  scenario "表示確認" do
    # 初期表示確認
    expect(page).to have_content 'まだ投稿はありません。'
  end

  scenario "投稿する" do
    content = Faker::Lorem.characters(number: 140)
    fill_in "post[content]", with: content
    click_button "投稿する"
    expect(page).to have_content "投稿しました"
    expect(page).to have_content content
    expect(page).to_not have_content 'まだ投稿はありません。'
  end

  describe "異常系" do
    it '投稿内容を入力しない' do
      click_button "投稿する"
      expect(page).to have_content "投稿内容を入力してください"
      expect(page).to have_content 'まだ投稿はありません。'
    end

    it '投稿内容に141文字入力する' do
      content = Faker::Lorem.characters(number: 141)
      fill_in "post[content]", with: content
      click_button "投稿する"
      expect(page).to have_content "投稿内容は140文字以内で入力してください"
      expect(page).to have_content 'まだ投稿はありません。'
    end
  end
end
