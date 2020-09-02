<template>
  <div class="main-contents" v-cloak>
    <img class="ari-logo" src="~login/ari-logo.png">
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
              <button class="close-btn" v-on:click="closeModal">Close</button>
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
            <div class="user-form__box">
              <input type="submit" value="ログイン" class="login-btn btn">
            </div>
            <div class="user-form__box">
              <img class="login-help__icon" src="~login/help.png" alt="ヘルプマーク">
              <a href="#" class="login-help__txt">
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
            <div class="user-form__box">
              <input type="submit" value="新規登録" class="login-btn btn">
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
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
  [v-cloak] {
      display: none;
  }

  ::placeholder {
    font-size: 10px;
  }

  .main-logo {
    height: 20vh;
  }

  .ari-logo {
    height: 120px;
    margin: 3% 0 0 12%;
  }

  .main-box {
    display: flex;
    width: 100vw;
    background-size: cover;
    background-image: url("~login/background-pink.png");
  }

  .main-box__img {
    display: flex;
    flex-direction: column;
    width: 50%;
    justify-content: center;
    align-items: center;
  }

  .thanks-img {
    max-width: 400px;
    width: 100%;
  }

  .pc-img {
    max-width: 720px;
    width: 100%;
  }

  .login-signup__content {
    flex-grow: 1;
  }

  .login-signup__box {
    width: 80%;
    margin: 0 auto;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
  }

  .login-signup__header {
    display: flex;
    justify-content: space-around;
    background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
    height: 70px;
    align-items: center;
    color: #fff;
    font-weight: bold;
  }

  .btn {
    cursor: pointer;
  }

  .transparent {
    opacity: 0.5;
  }

  .active {
    color: #fff;
    opacity: 1;
    position: relative;
  }

  .active::after {
    content: "";
    position: absolute;
    right: 0;
    bottom: -25px;
    left: 0;
    width: 0px;
    height: 0px;
    margin: auto;
    border-style: solid;
    border-color: #fff transparent transparent transparent;
    border-width: 15px 15px 0 15px;
    transform: rotate(180deg);
  }

  .user-form {
    background: #fff;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 10% 0;
  }

  .user-form__box {
    display: flex;
    justify-content: center;
    padding: 30px 0 0 0;
  }

  .user-form__box:first-child {
    padding: 0;
  }

  .user-form__box input {
    height: 50px;
    width: 60%;
    border: 1px solid red;
  }

  .form-half {
    display: flex;
  }

  .form-half input:first-child {
    margin-right: 10%;
  }

  .form-half input {
    width: 25%;
  }

  .login-btn {
    width: 200px;
    height: 50px;
    background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
    color: white;
    box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    border: none;
    border-radius: 30px;
    font-weight: bold;
  }

  .login-help__icon {
    height: 18px;
    margin-right: 30px;
  }

  .login-help__txt {
    font-size: 12px;
    color: #888888;
  }

  .login-help__txt::after {
    content: "▶️";
    margin-left: 30px;
  }

  /* ログインポップアップ*/
  .overlay{
    width: 60%;
    height: 50%;
    z-index: 1;
    position: fixed;
    top: 25%;
    left: 20%;
    background-color: #fff;
    border-radius: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .error-message {
    display: block;
    margin-bottom: 40px;
    padding-top: 40px;
    font-size: 20px;
    text-align: center;
  }

  .success-message {
    display: block;
    margin-bottom: 40px;
    padding-top: 40px;
    font-size: 20px;
    color: #92CECA;
    text-align: center;
  }

  .sub-message {
    font-size: 14px;
    text-align: center;
  }

  .close-btn {
    display: block;
    margin: auto;
    width: 200px;
    height: 50px;
    border-radius: 25px;
    border: none;
  }
</style>
