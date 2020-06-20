<template>
  <div class="login-form__conts">

    <!-- ログインポップアップ-->
    <div class="login-popup">
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

    <!-- ログインフォーム-->
    <form action="/users/sign_in" accept-charset="UTF-8" method="post" class="login-form" @submit.prevent="createPass">
      <img src='~ari-letter-logo.jpg' class="ari-logo">
      <div class="login-form__content">
        <label for="email">E-Mail</label>
        <input type="email" id="email" v-model="email" placeholder="例）taro.yamada@di-v.co.jp">
      </div>
      <div class="login-form__content">
        <label for="pass">PASS</label>
        <input type="password" id="pass" placeholder="例）6文字以上の半角英数字" v-model="password">
      </div>
      <input type="submit" value="ログイン" class="login-form__btn">
      <div class="login-form__help">
        <img class="login-form__icon" src="~login-help.png" alt="ヘルプマーク">
        <a href="/users/password/new" class="login-form__txt">
          パスワードを再設定する
        </a>
      </div>
      <div class="login-form__sign-up">
        <img class="login-form__icon" src="~login-beginner.png" alt="初心者マーク">
        <a class="login-form__txt" href="/users/sign_up">
          初めて利用する方はこちら
        </a>
      </div>
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
      email: '',
      password: '',
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
    },
    resetForm: function(){
      this.$data.email = ''
      this.$data.password = ''
    },
    createPass: function(event) {
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
              setTimeout(function(){
                location.href = "/"
                },1000);
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
  .login-form__conts{
    background-color: #F8F8F8;
    width: 50%;
    height: 80vh;
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
  .login-form {
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

  .login-form__content {
    display: flex;
    width: 100%;
    padding: 40px 100px 0 100px;
  }

  .login-form__content label {
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

  .login-form__content input {
    display: inline-block;
    flex-grow: 1;
    height: 50px;
    background-color: #fff;
    box-sizing: border-box;
    border: none;
    padding-left: 15px;
    margin-right: 50px;
  }

  .login-form__btn {
    width: 200px;
    height: 50px;
    background: #FFC152;
    color: white;
    box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    border: none;
    border-radius: 30px;
    margin: 40px 0;
  }

  .login-form__help {
    margin-bottom: 20px;
  }

  .login-form__icon {
    height: 12px;
    margin-right: 30px;
  }

  .login-form__txt {
    font-size: 12px;
    color: #888888;
  }

  .login-form__txt::after {
    content: "▶️";
    margin-left: 30px;
  }
</style>
