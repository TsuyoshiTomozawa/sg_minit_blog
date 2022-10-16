require 'rails_helper'

RSpec.describe "EditUsers", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
    visit edit_user_registration_path
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
    password = Faker::Lorem.characters(number: 6)
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

  describe "異常系" do
    it '現在のパスワードを入力しない' do
      fill_in "user[name]", with: "tester"
      click_button "更新"
      expect(page).to have_content "Current passwordを入力してください"
    end

    it 'ユーザー名を入力しない' do
      fill_in "user[name]", with: ""
      fill_in "user[current_password]", with: @user.password
      click_button "更新"
      expect(page).to have_content "Nameを入力してください"
    end

    it 'ユーザー名を21文字入力する' do
      name = Faker::Lorem.characters(number: 21)
      fill_in "user[name]", with: name
      fill_in "user[current_password]", with: @user.password
      click_button "更新"
      expect(page).to have_content "Nameは20文字以内で入力してください"
    end

    it 'ユーザー名にスペースを含める' do
      fill_in "user[name]", with: "tester user"
      fill_in "user[current_password]", with: @user.password
      click_button "更新"
      expect(page).to have_content "Nameはアルファベットのみが使えます"
    end

    it 'ユーザー名に数字を含める' do
      fill_in "user[name]", with: "tester1"
      fill_in "user[current_password]", with: @user.password
      click_button "更新"
      expect(page).to have_content "Nameはアルファベットのみが使えます"
    end

    it 'パスワードが５文字' do
      password = Faker::Lorem.characters(number: 5)
      fill_in "user[name]", with: "tester"
      fill_in "user[current_password]", with: @user.password
      fill_in "user[password]", with: password
      fill_in "user[password_confirmation]", with: password
      click_button "更新"
      expect(page).to have_content "Passwordは6文字以上で入力してください"
    end

    it 'パスワードと確認パスワードが一致しない' do
      fill_in "user[name]", with: "tester"
      fill_in "user[current_password]", with: @user.password
      fill_in "user[password]", with: Faker::Lorem.characters(number: 6)
      fill_in "user[password_confirmation]", with: Faker::Lorem.characters(number: 6)
      click_button "更新"
      expect(page).to have_content "confirmationとPasswordの入力が一致しません"
    end

    it 'プロフィールが201文字を入力' do
      fill_in "user[name]", with: "tester"
      fill_in "user[current_password]", with: @user.password
      fill_in "user[profile]", with: Faker::Lorem.characters(number: 201)
      click_button "更新"
      expect(page).to have_content "Profileは200文字以内で入力してください"
    end

    it 'ブログURLの形式が不正' do
      fill_in "user[name]", with: "tester"
      fill_in "user[current_password]", with: @user.password
      fill_in "user[blog_url]", with: Faker::Lorem.characters(number: 10)
      click_button "更新"
      expect(page).to have_content "Blog urlは不正な値です"
    end
  end

  scenario '戻るボタン', js: true do
    click_on "戻る"
    expect(current_path).to eq root_path
  end
end
