# TOPページ
rails: thanks/#index
js: javascript/packs/thanks_index.js
vue: {
  <!-- TOPページ作成 -->
  <!-- TOPページの親コンポーネント -->
  parent:         javascript/components/top/ThanksIndex.vue,
  <!-- 子コンポーネント -->
  child:          [ javascript/components/shared/Header.vue,
                    <!-- マイページの一覧 -->
                    javascript/components/shared/NavMypage.vue,
                    <!-- 全社員の一覧 -->
                    javascript/components/shared/NavAll.vue,
                    <!-- コンテンツ用 -->
                    javascript/components/shared/Contents.vue          
                  ],
  <!-- 孫コンポーネント(ボタン) -->
  grandchildren:  [ javascript/components/shared/parts/NavBtn.vue,
                  ],
  <!-- ひ孫コンポーネント(ボタンの部品) -->
  great - 
  grandchildren:  [
                    <!-- ボタンの丸ポチ -->
                    javascript/components/shared/parts/CheckBox.vue,
                    <!-- ボタンの名前 -->
                    javascript/components/shared/parts/NavName.vue
                  ]
}

# 受信ページ
rails: receptions/#index
js: javascript/packs/receptions_index.js
vue: {
  parent: 
  child: 
}
# ログインページ
rails: users/sessions#new
js: javascript/packs/login.js
vue: {
  parent: components/login/Login.vue
  child: components/login/Logincontens.vue
}

# ユーザー新規登録ページ
rails: users/registrations#new
js: javascript/packs/sign_up.js
vue: {
  parent: components/sign_up/SignUp.vue
  child: components/sign_up/SignUpContens.vue
}

# パスワード再設定ページ
rails: users/passwords#new
js: javascript/packs/reset_password.js
vue: {
  parent: components/reset_password/ResetPassword.vue
  child: components/reset_password/ResetPasswordContents.vue
}