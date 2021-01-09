<template>
  <main id="app" class="container">
    <div class="main-contents" v-cloak>
      <div class="main-header">
        <img class="ari-logo" src="~login/ari-logo.png">
      </div>
      <div class="main-box">
        <div class="main-box__img">
          <img class="thanks-img" src="~login/thanks-text.png">
          <img class="pc-img" src="~login/pc.png">
        </div>

        <div class="login-signup__content">
          <!-- ポップアップ-->
          <div class="login-popup">
            <div class="overlay" v-show="showContent">
              <div class="content">
                <div class="error-message" v-if="errors.length != 0">
                  <ul v-show="signupForm" v-for="e in errors" :key="e">
                    <li><font color="red">{{ e }}</font></li>
                  </ul>
                  <ul v-show="loginForm">
                    <li><font color="red">{{ errors }}</font></li>
                  </ul>
                </div>
                <p class="success-message" v-if="errors.length == 0" v-show="loginForm">ログインに成功しました！<br><span class="sub-message">早速感謝の言葉をお伝えしましょう</span></p>
                <p class="success-message" v-if="errors.length == 0" v-show="signupForm">登録が完了しました！<br><span class="sub-message">早速感謝の言葉をお伝えしましょう</span></p>
                <button class="btn btn-color-close btn-size-md btn-type-round" v-on:click="closeModal">Close</button>
              </div>
            </div>
          </div>
          <div class="login-signup__box">
            <div class="login-signup__header">
              <div class="login-box btn transparent active" @click="activeBtn" data-name="login">
                ログイン
              </div>
              <div class="signup-box btn transparent" @click="activeBtn" data-name="signup">
                新規登録
              </div>
            </div>
            <!--ログインフォーム-->
            <form action="/users/sign_in" accept-charset="UTF-8" method="post" class="user-form" v-show="loginForm" @submit.prevent="loginUser">
              <div class="user-form__box">
                <input type="email" id="email" v-model="email" placeholder="メールアドレス" v-cloak>
              </div>
              <div class="user-form__box">
                <input type="password" id="pass" placeholder="パスワード 英数字6文字以上" v-model="password" autocomplete="new-password" v-cloak>
              </div>
              <div class="user-form__btn">
                <input type="submit" value="ログイン" class="login-btn btn btn-color-primary btn-size-md btn-type-round">
              </div>
              <div class="user-form__help">
                <img class="user-form__help-icon" src="~login/help.png" alt="ヘルプマーク">
                <a href="#" class="user-form__help-txt">
                  パスワードを再設定する
                </a>
              </div>
            </form>

            <!--新規登録フォーム-->
            <form action="/users" accept-charset="UTF-8" method="post" class="user-form" v-show="signupForm" @submit.prevent="createUser">
              <div class="user-form__box form-half">
                <input type="text" id="family_name" v-model="family_name" placeholder="苗字" v-cloak>
                <input type="text" id="given_name" v-model="given_name" placeholder="名前" v-cloak>
              </div>
              <div class="user-form__box">
                <input type="email" id="email" v-model="email" placeholder="メールアドレス" v-cloak>
              </div>
              <div class="user-form__box">
                <input type="password" id="password" placeholder="パスワード 英数字6文字以上" v-model="password" autocomplete="new-password" v-cloak>
              </div>
              <div class="user-form__box">
                <input type="password" id="password-conf" placeholder="パスワード確認 英数字6文字以上" v-model="password_conf" autocomplete="new-password" v-cloak>
              </div>
              <div class="user-form__btn">
                <input type="submit" value="新規登録" class="login-btn btn btn-color-primary btn-size-md btn-type-round">
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'login/help.png';
import 'login/background-pink.png';
import 'login/ari-logo.png';
import 'login/thanks-text.png';
import 'login/pc.png';

export default {
  data: function(){
    return{
      errors: '',
      email: '',
      password: '',
      family_name: '',
      given_name: '',
      password_conf: '',
      loginForm: true,
      signupForm: false,
      showContent: false
    }
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  },
  methods: {
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
      setTimeout(function(){
        location.href = "/"
      },10);
    },
    resetForm: function(){
      this.$data.email = ''
      this.$data.password = ''
    },
    loginUser: function(event) {
      axios
        .post('/users/sign_in', {email: this.email, password: this.password})
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            }
            else{
              this.openModal();
            }
          } else {
            let e = response.data;
          }
          this.openModal();
          this.resetForm();
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      },
    createUser: function(e){
      axios
        .post('/users', {family_name: this.family_name, given_name: this.given_name, email: this.email, password: this.password, password_confirmation: this.password_conf})
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            }
            else{
              this.openModal();
            }
          } else {
            let e = response.data;
          }
          this.openModal();
          this.resetForm();
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    activeBtn: function(e){
      let element = document.getElementsByClassName('active');
      if (e.currentTarget.dataset.name == "login"){
         this.$data.loginForm = true
         this.$data.signupForm = false
      } else {
         this.$data.loginForm = false
         this.$data.signupForm = true
      }
      element[0].classList.remove('active');
      e.currentTarget.classList.add("active");
    }
  }

}
</script>

<style scoped>


</style>
