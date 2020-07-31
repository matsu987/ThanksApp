module SignIn
  def sign_in(user)
    # サインインページへ移動する
    ActionController::Base.allow_forgery_protection = true

    visit  new_user_session_path

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'email', with: user.email
    fill_in 'pass', with: user.password

    # ログインボタンをクリックする
    click_button "ログイン"
    sleep 3

  end

end