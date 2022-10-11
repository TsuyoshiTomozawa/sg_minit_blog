require 'rails_helper'

RSpec.describe "EditUsers", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
    visit user_edit_path
  end

  scenario "表示確認" do
    expect(page).to have_content 'ユーザー名'
    expect(page).to have_content 'パスワード'
    expect(page).to have_content 'パスワード確認'
    expect(page).to have_content '現在のパスワード'
    expect(page).to have_content 'プロフィール'
    expect(page).to have_content 'ブログURL'
  end

  it 'ユーザー名更新' do
    fill_in "user[name]", with: "tester"
    fill_in "user[current_password]", with: @user.password
    click_button "更新"
    puts @user.reload.name
    expect(page).to have_content "アカウント情報を変更しました。"
    expect(current_path).to eq root_path
    expect(@user.reload.name).to eq "tester"
  end

  it 'パスワード更新' do
    password ='passwordsample'
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password
    fill_in "user[current_password]", with: @user.password
    click_button "更新"
    expect(page).to have_content "アカウント情報を変更しました。"
    expect(current_path).to eq root_path

    # puts @user.reload.password FIXME: リロードしてもパスワードが更新されない。

    sign_out()

    # インスタンスのパスワードが更新されないが、新しいパスワードで更新できることの確認
    visit login_path
    fill_in "user[name]", with: @user.name
    fill_in "user[password]", with: password
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
    expect(current_path).to eq root_path
  end

  it 'プロフィール更新' do
    profile = Faker::Lorem.characters(number: 200)
    fill_in "user[profile]", with: profile
    fill_in "user[current_password]", with: @user.password
    click_button "更新"
    expect(page).to have_content "アカウント情報を変更しました。"
    expect(current_path).to eq root_path
    expect(@user.reload.profile).to eq profile
  end

  it 'ブログURL更新' do
    blog_url = Faker::Internet.url(host: 'faker')
    fill_in "user[blog_url]", with: blog_url
    fill_in "user[current_password]", with: @user.password
    click_button "更新"
    expect(page).to have_content "アカウント情報を変更しました。"
    expect(current_path).to eq root_path
    expect(@user.reload.blog_url).to eq blog_url
  end

  scenario '戻るボタン', js: true do
    click_on "戻る"
    expect(current_path).to eq root_path
  end

  describe  do

  end
end
