module SignOutModule
  def sign_out()
    visit root_path
    click_link "ログアウト"
  end
end