require 'rails_helper'

RSpec.describe "Signups", type: :system do
  scenario "表示確認" do
    visit new_user_registration_path
    expect(page).to have_link 'ログイン'
    expect(page).to have_content 'ユーザー名'
    expect(page).to have_content 'パスワード'
    expect(page).to have_content 'パスワード確認'
  end

  scenario "新規作成処理の確認" do
    visit new_user_registration_path
    fill_in "user[name]", with: "test"
    fill_in "user[password]", with: 'password'
    fill_in "user[password_confirmation]", with: 'password'
    click_button "登録"
    expect(page).to have_content "アカウント登録が完了しました。"
    expect(current_path).to eq root_path
  end

  describe "異常系" do
    context "ユーザー名" do
      it 'ユーザー名が空' do
        visit new_user_registration_path
        fill_in "user[password]", with: 'password'
        fill_in "user[password_confirmation]", with: 'password'
        click_button "登録"
        expect(page).to have_content "下記の問題をご確認ください。:"
        expect(page).to have_content "Nameを入力してください"

      end

      it 'ユーザー名に数字を含める' do
        visit new_user_registration_path
        fill_in "user[name]", with: "test1"
        fill_in "user[password]", with: 'password'
        fill_in "user[password_confirmation]", with: 'password'
        click_button "登録"
        expect(page).to have_content "下記の問題をご確認ください。:"
        expect(page).to have_content "Nameはアルファベットのみが使えます"
        expect(current_path).to eq '/users'
      end
    end

    context 'パスワード' do

      it 'パスワードが空' do
        visit new_user_registration_path
        fill_in "user[name]", with: "test"
        fill_in "user[password_confirmation]", with: 'password'
        click_button "登録"
        expect(page).to have_content "下記の問題をご確認ください。:"
        expect(page).to have_content "Passwordを入力してください"
        visit current_path
        expect(current_path).to eq new_user_registration_path
      end

      it 'パスワード確認が空' do
        visit new_user_registration_path
        fill_in "user[name]", with: "test"
        fill_in "user[password]", with: 'password'
        click_button "登録"
        expect(page).to have_content "下記の問題をご確認ください。:"
        expect(page).to have_content "Password confirmationとPasswordの入力が一致しません"
      end

      it 'パスワードとパスワード確認が一致しない' do
        visit new_user_registration_path
        fill_in "user[name]", with: "test"
        fill_in "user[password]", with: 'password'
        fill_in "user[password_confirmation]", with: 'passwords'
        click_button "登録"
        expect(page).to have_content "下記の問題をご確認ください。:"
        expect(page).to have_content "Password confirmationとPasswordの入力が一致しません"
      end
    end

    it '新規登録に失敗後、リロードしても新規登録画面が表示されることの確認' do
      visit new_user_registration_path
      fill_in "user[name]", with: "test"
      fill_in "user[password]", with: 'password'
      click_button "登録"
      expect(current_path).to eq '/users'
      visit current_path
      expect(current_path).to eq new_user_registration_path
    end
  end

end
