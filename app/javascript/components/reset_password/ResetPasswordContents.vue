<template>
  <div class="reset-form__conts">

    <!-- ポップアップ -->
    <div class="reset-popup">
      <div class="overlay" v-show="showContent">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li><font color="red">{{ errors }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">{{ success_introduction }}</p>
          <button class="close-btn" v-on:click="closeModal">
            <a v-if="errors.length == 0" href="/">Close</a>
            <p v-if="errors.length != 0">Close</p>
          </button>
        </div>
      </div>
    </div>

    <!-- パスワードリセットフォーム -->
    <form action="/users/password" accept-charset="UTF-8" method="post" class="reset-form" @submit.prevent="createPass">
      <img src='~ari-letter-logo.jpg' class="ari-logo">
      <div class="reset-form__message">
        パスワードをお忘れの場合は登録メールアドレスを入力して入力してパスワードの再設定を行ってください。<br>
        パスワード再設定用のメールをお送りします。<br>
      </div>
      <div class="reset-form__content">
        <label for="email">Email</label>
        <input type="email" id="email" placeholder="例）taro.yamada@di-v.co.jp" v-model="email">
      </div>
      <input type="submit" name="commit" value="認証メールを送信する" class="reset-form__btn">
      <a href="/" class="reset-form__txt">
        ログインページに戻る︎
      </a>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import 'ari-letter-logo.jpg';

export default {
  data: function(){
    return{
      errors: '',
      email: '',
      password: '',
      success_introduction: '',
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
        .post('/users/password', {email: this.email})
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors_introduction) {
            this.errors = response.data.errors_introduction;
            }
            else{
              this.success_introduction = response.data.success_introduction;
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
  .reset-form__conts{
    background-color: #F8F8F8;
    width: 50%;
    height: 80vh;
    box-sizing: border-box;
    border-radius: 40px;
  }
  /* ログインポップアップ*/
  /* .overlay{
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
  } */

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
  .reset-form {
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

  .reset-form__message {
    width: 52%;
    font-size: 12px;
    color: #888888;
    margin-top: 40px;
  }

  .reset-form__content {
    display: flex;
    width: 100%;
    padding: 40px 100px 0 100px;
  }

  .reset-form__content label {
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

  .reset-form__content input {
    display: inline-block;
    flex-grow: 1;
    height: 50px;
    background-color: #fff;
    box-sizing: border-box;
    border: none;
    padding-left: 15px;
    margin-right: 50px;
  }

  .reset-form__btn {
    width: 200px;
    height: 50px;
    background: #FFC152;
    color: white;
    box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    border: none;
    border-radius: 30px;
    margin: 40px 0;
  }

  .reset-form__help {
    margin-bottom: 20px;
  }

  .reset-form__icon {
    height: 12px;
    margin-right: 30px;
  }

  .reset-form__txt {
    font-size: 12px;
    color: #888888;
  }

  .reset-form__txt::after {
    content: "▶️";
    margin-left: 30px;
  }
</style>
