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