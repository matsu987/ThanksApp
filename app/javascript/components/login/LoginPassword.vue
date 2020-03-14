<template>
  <div class="password_contents">
    <div class="overlay" v-show="showContent">
      <div class="content">
        <div class="error-message" v-if="errors.length != 0">
          <ul >
            <li><font color="red">{{ errors }}</font></li>
          </ul>
        </div>
        <p class="success-message" v-if="errors.length == 0">パスワード入力確認いたしました！<br><span class="sub-message">早速感謝の言葉をお伝えしましょう^^</span></p>
        <button class="close-btn" v-on:click="closeModal">Close</button>
      </div>
    </div>
    <form action="/users/sign_in" accept-charset="UTF-8" method="post" @submit.prevent="createPass">
      <div class="form_content">
        <div class="email_form">
          <label for="email">E-Mail</label>
          <input type="email" id="email" placeholder="emailを入力してください" v-model="email">
        </div>
        <div class="password_form">
          <label for="pass">PASS</label>
          <input type="password" id="pass" placeholder="passwordを入力してください" v-model="password">
        </div>
      </div>
      <div class="form_bottom_content">
        <input type="submit" value="ログイン">
        <p>
          <i class="far fa-question-circle"></i>
          <a href="/users/password/new" class="resetting_pass">
            パスワードを忘れた ▶ ︎
          </a>
        </p>
        <p>
          <img src="~first_login.png" alt="初心者マーク">
          <a href="/users/confirmation/new" class="resetting_pass">
            認証がまだのかたはこちら ▶ ︎
          </a>
        </p>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import 'first_login.png';

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
              setTimeout("location.reload()",1000);
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
  .form_content{
    margin: 90px 0 40px; 
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
    padding-right: 9px;
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
    filter: drop-shadow(5px 5px 5px rgba(0, 0, 0, 0.25));
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
  color: #ADDCD9;
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
