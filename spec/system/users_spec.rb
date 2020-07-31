require 'rails_helper'

RSpec.describe "Users", type: :system do

  context '新規登録機能' do
    it '新規登録に成功する' do
      # ユーザーサインイン画面に遷移する
      visit new_user_session_path

      # 新規登録画面へ移動するリンクをクリックする
      click_on('初めて利用する方はこちら')

      # 新規登録画面へ遷移していることを期待する
      expect(current_path).to eq new_user_registration_path

      # フォームにユーザー登録に必要な値を入力する
      fill_in 'family_name', with: "test"
      fill_in 'given_name', with: "太郎"
      fill_in 'email', with: "example@test.com"
      fill_in 'password', with: "123456"
      fill_in 'password-conf', with: "123456"

      # 登録ボタンを押し、ユーザー情報を確定させる
      click_button '新規登録'

      # 成功のポップアップが出ていることを期待する
      expect(page).to have_content('パスワード入力確認いたしました！')
      expect(page).to have_content('早速感謝の言葉をお伝えしましょう')

      # ポップアップをcloseする
      click_on('Close')

      # ページ遷移を待つ
      sleep 3

      # TOPページに繊維していることを期待する
      expect(current_path).to eq root_path
    end
    it 'emailの入力に不備があり、新規登録が失敗する' do
      # ユーザーサインイン画面に遷移する
      visit new_user_session_path

      # 新規登録画面へ移動するリンクをクリックする
      click_on('初めて利用する方はこちら')

      # 新規登録画面へ遷移していることを期待する
      expect(current_path).to eq new_user_registration_path

      # フォームにユーザー登録に必要な値を入力する
      fill_in 'family_name', with: "test"
      fill_in 'given_name', with: "太郎"
      fill_in 'email', with: "exampletest.com"
      fill_in 'password', with: "123456"
      fill_in 'password-conf', with: "123456"

      # 登録ボタンを押し、ユーザー情報を確定させる
      click_button '新規登録'

      # 新規登録画面へ遷移していることを期待する
      expect(current_path).to eq new_user_registration_path
    end
  end

  context 'ログイン機能' do
    let(:user) {create(:user)}
    it 'ログインしていない場合、サインページに移動する' do
      # トップページに遷移する
      visit root_path

      # ログインしていない場合、サインインページに遷移することを期待する
      expect(current_path).to eq new_user_session_path
    end
    context 'ログインに成功する場合' do
      it 'ログインに成功し、ルートパスに遷移する' do
        # 自作したモジュールによってサインインする
        sign_in(user)

        expect(current_path).to eq root_path

        # 必要な表示が存在していることを期待する
        expect(page).to have_content('新規登録')
        expect(page).to have_content('選択')
      end
    end
    context 'ログインが失敗する場合' do
      it 'emailが誤っていてログインが失敗した結果、ポップアップが表示される' do
        user.email = "example@test.com"
        sign_in(user)
        expect(page).to have_content('無効なemailまたはpasswordです。')
      end
      it 'passwordが誤っていてログインが失敗した結果、ポップアップが表示される' do
        user.password = "123456"
        sign_in(user)
        expect(page).to have_content('無効なemailまたはpasswordです。')
      end
    end
  end

  context 'ユーザー編集機能' do
    let(:user) {create(:user)}

    it '編集画面への繊維に成功する' do
      sign_in(user)

      visit edit_user_path(user.id)

      expect(current_path).to eq edit_user_path(user.id)
    end
    it '基本情報の編集に成功する' do
      sign_in(user)

      # 編集前の値をそれぞれ変数に代入
      user_family_name = user.email
      user_given_name = user.password

      # 編集画面に繊維する
      visit edit_user_path(user.id)

      # 「姓」と「名」を入力する
      find_all(".user__form__boxies__box__text")[0].set("#{user_family_name }aaa")
      find_all(".user__form__boxies__box__text")[1].set("#{user_given_name}aaa")

      #「変更」ボタンを押して編集を確定する
      find(".user__form__submit").click

      sleep 3

      #「姓」と「名」が入力されている値であることを期待する
      expect(page).to have_selector "input[placeholder='#{user.reload.family_name}']"
      expect(page).to have_selector "input[placeholder='#{user.reload.given_name}']"
    end
    it 'ログイン情報の編集に成功する' do
      sign_in(user)

      # 編集前の値をそれぞれ変数に代入
      user_email = user.email
      user_password = user.password

      visit edit_user_path(user.id)

      # 「メールアドレス」と「パスワード」を入力する
      find("input[type='email']").set(user_email + "aaa")
      find("input[type='password']").set(user_password +"aaa")

      # 「変更」ボタンを押して編集を確定する
      find(".login__form__submit").click

      expect(page).to have_content('登録が完了しました！')

      click_on('Close')

      # 「メールアドレス」が入力された値であることを期待する
      expect(page).to have_selector "input[placeholder='#{user.reload.email}']"

      # 「パスワード」の欄が空になっていることを期待する
      expect(page).to have_selector "input[type='password']", text: ""
    end
    it 'アバターの編集に成功する' do
      sign_in(user)

      visit edit_user_path(user.id)

      # ダミー画像取得する
      image_path = Rails.root.join("spec", "fixtures", "sample.jpg")
      img = Rack::Test::UploadedFile.new(image_path)
      user.avatar = img

      # ダミー画像をDBに保存する
      user.save

      find(".user__form__submit").click

      expect(page).to have_content('登録が完了しました！')

      click_on('Close')

      # 設定したアバターが保存されていることを期待する
      expect(user.avatar.identifier).to eq "sample.jpg"

      # src属性にアバターが設定されていることを期待する
      expect(page).to have_selector "img[src$='/uploads/user/avatar/#{user.id}/sample.jpg']"
    end
  end
end
