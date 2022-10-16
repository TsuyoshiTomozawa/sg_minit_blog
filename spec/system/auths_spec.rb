require 'rails_helper'

RSpec.describe "Auths", type: :system do
  scenario "ログインする" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    expect(current_path).to eq root_path
    expect(cookie(:remember_user_token)).to eq nil
  end

  scenario "remember me" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    check "Remember me"
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    expect(current_path).to eq root_path
    expect(cookie(:remember_user_token)).to_not eq nil

    puts cookie_expires # FIXME 有効期限のtimezoneがUCのため、現在時刻と比較できず
  end

  describe "異常系" do
    it 'ユーザー名が空' do
      user = FactoryBot.create(:user)
      visit login_path
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      expect(page).to have_content "が不正です。"
      expect(current_path).to eq new_user_session_path
    end

    it 'パスワードが空' do
      user = FactoryBot.create(:user)
      visit login_path
      fill_in "user[name]", with: user.name
      click_button "ログイン"
      expect(page).to have_content "もしくはパスワードが不正です。"
      expect(current_path).to eq new_user_session_path
    end
  end

  scenario "ユーザー新規登録への導線確認" do
    visit login_path
    expect(page).to have_link 'ユーザー新規登録'
    click_link 'ユーザー新規登録'
    expect(current_path).to eq new_user_registration_path
  end

  scenario "ログアウトする" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "ログイン"

    expect(current_path).to eq root_path
    click_link "ログアウト"
    expect(current_path).to eq login_path
    expect(page).to have_content "ログアウトしました。"
  end
end
