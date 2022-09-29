require 'rails_helper'

RSpec.describe "Auths", type: :system do
  scenario "ログインする" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    expect(current_path).to eq root_path
    expect(cookie(:remember_user_token)).to eq nil
  end

  scenario "remember me" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    check "Remember me"
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    expect(current_path).to eq root_path
    expect(cookie(:remember_user_token)).to_not eq nil

    puts cookie_expires # FIXME 有効期限のtimezoneがUCのため、現在時刻と比較できず
  end

  scenario "ログアウトする" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "ログイン"

    expect(current_path).to eq root_path
    click_link "ログアウト"
    expect(current_path).to eq login_path
    expect(page).to have_content "ログアウトしました。"
  end
end
