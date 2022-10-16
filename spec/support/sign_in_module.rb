module SignInModule
  def sign_in_as(user)
    visit login_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end
end