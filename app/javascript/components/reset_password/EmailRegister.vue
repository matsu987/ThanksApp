<template>
  <div class="password_contents">
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
    <div class="introduction">
      <p>パスワードをお忘れの場合は</p><br>
      <p>登録メールアドレスを入力して入力してパスワードの再設定を行ってください。</p><br>
      <p>パスワード再設定用のメールをお送りします。</p>
    </div>
    <form action="/users/password" accept-charset="UTF-8" method="post" @submit.prevent="createPass">
      <div class="form_content">
        <div class="password_form">
          <label for="email">E-mail</label>
          <input autocomplete="on" type="email" id="email" v-model="email" placeholder="taro.yamada@di-v.co.jp">
        </div>
      </div>
      <div class="form_bottom_content">
        <input type="submit" name="commit" value="認証メールを送信する。">
        <p>
          <img src="~first_login.png" alt="初心者マーク">
          <a href="/users/confirmation/new" class="resetting_pass">
            初めて利用する方はこちら ▶ ︎
          </a>
        </p>
        <p>
          <a href="/" class="resetting_pass">
            ◀︎ ログインページに戻る︎
          </a>
        </p>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import 'first_login.png';

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
  .password_contents{
    background-color: #FAFAFA;
    width: 800px;
    height: 400px;
    box-sizing: border-box;
  }
  .introduction{
    margin-top: 40px;
  }
  .introduction p{
    display: inline;
    font-family: Noto Sans CJK JP;
    font-size: 14px;
    line-height: 21px;
    text-align: center;
    letter-spacing: 0.05em;
    color: #333333;
  }
  .form_content{
    margin: 35px 0 40px; 
  }
  .form_content label{
    display: inline-block;
    background-color: #888888;
    width: 100px;
    line-height: 50px;
    color: #FFFFFF;
    font-family: Noto Sans CJK JP;
    font-size: 14px;
    letter-spacing: 0.02em;
  }
  .form_content input{
    display: inline-block;
    width: 250px;
    height: 50px;
    background-color: #FFFFFF;
    box-sizing: border-box;
  }
  .form_content .password_form{
    padding-top: 33px;
  }
  .form_bottom_content input{
    width: 200px;
    height: 40px;
    color: #FFFFFF;
    border-radius: 40px;
    background-color: #FFC152;
    filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));
    border:none;
  }
  .form_bottom_content .resetting_pass{
    display: inline-block;
    padding-top: 20px;
    color: #888888;
    font-family: Noto Sans CJK JP;
    letter-spacing: 0.02em;
  }
  .overlay{
    width: 50%;
    height: 50%;
    z-index: 1;
    position: fixed;
    top: 25%;
    left: 25%;
    background-color: #fff;
    border: 2px solid #555555;
    box-sizing: border-box;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .close-btn {
    display: block;
    margin: auto;

  }

  .success-message {
    display: block;
    margin-bottom: 40px;
    padding-top: 40px;
    font-size: 20px;
    color: #92CECA;;
    text-align: center;
  }

  .sub-message {
      font-size: 14px;
      text-align: center;
  }

  .error-message {
    display: block;
    margin-bottom: 40px;
    padding-top: 40px;
    font-size: 20px;
    text-align: center;
  }
</style>
