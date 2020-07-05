<template>
  <div class="signup-form__conts">

    <!-- ポップアップ-->
    <div class="signup-popup">
      <div class="overlay" v-show="showContent">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li><font color="red">{{ errors }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">パスワード入力確認いたしました！<br><span class="sub-message">早速感謝の言葉をお伝えしましょう</span></p>
          <button class="close-btn" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </div>

    <!-- サインアップフォーム-->
    <form action="/users/sign_up" accept-charset="UTF-8" method="post" class="signup-form" @submit.prevent="createUser">
      <img src='~ari-letter-logo.jpg' class="ari-logo">
      <div class="signup-form__content">
        <label for="family_name">FamilyName</label>
        <input type="text" id="family_name" v-model="family_name" placeholder="例）山田">
      </div>
      <div class="signup-form__content">
        <label for="given_name">GivenName</label>
        <input type="text" id="given_name" v-model="given_name" placeholder="例）太郎">
      </div>
      <div class="signup-form__content">
        <label for="email">E-Mail</label>
        <input type="email" id="email" v-model="email" placeholder="例）taro.yamada@di-v.co.jp">
      </div>
      <div class="signup-form__content">
        <label for="password">Password</label>
        <input type="password" id="password" placeholder="例）6文字以上の半角英数字" v-model="password">
      </div>
      <div class="signup-form__content password_conf">
        <label for="password_conf">Password Confirmation</label>
        <input type="password" id="password-conf" placeholder="例）6文字以上の半角英数字" v-model="password_conf">
      </div>
      <input type="submit" value="新規登録" class="signup-form__btn">
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import 'ari-letter-logo.jpg';
import 'login-help.png';
import 'login-beginner.png';

export default {
  data: function(){
    return{
      errors: '',
      family_name: '',
      given_name: '',
      email: '',
      password: '',
      password_conf: '',
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
    createUser: function(event) {
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
    }

}
</script>

<style scoped>
  .signup-form__conts{
    background-color: #F8F8F8;
    width: 50%;
    height: 94vh;
    box-sizing: border-box;
    border-radius: 40px;
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

  /* ログインフォーム */
  .signup-form {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .ari-logo {
    height: 150px;
    width: 150px;
    margin-top: 20px;
  }

  .signup-form__content {
    display: flex;
    width: 100%;
    padding: 40px 100px 0 100px;
  }

  .signup-form__content label {
    display: inline-block;
    background-color: #888888;
    width: 100px;
    line-height: 50px;
    text-align: center;
    color: #FFFFFF;
    font-family: Noto Sans CJK JP;
    font-size: 11px;
    letter-spacing: 0.02em;
    margin: 0 20px 0 50px;
  }

  .password_conf label {
    line-height: 23px;
  }

  .signup-form__content input {
    display: inline-block;
    flex-grow: 1;
    height: 50px;
    background-color: #fff;
    box-sizing: border-box;
    border: none;
    padding-left: 15px;
    margin-right: 50px;
  }

  .signup-form__btn {
    width: 200px;
    height: 50px;
    background: #FFC152;
    color: white;
    box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    border: none;
    border-radius: 30px;
    margin: 40px 0;
  }
</style>
