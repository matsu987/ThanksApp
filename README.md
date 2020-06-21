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