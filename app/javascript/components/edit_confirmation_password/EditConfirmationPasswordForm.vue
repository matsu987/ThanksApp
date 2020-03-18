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
    <form @submit.prevent="setPass">
      <div class="form_content">
        <div class="password_form">
          <label for="pass">Pass</label>
          <input autocomplete="on" type="password" id="pass" v-model="password">
        </div>
      </div>
      <div class="form_bottom_content">
        <input type="submit" name="commit" value="パスワードを確定する">
          <p>
            <a href="#" class="resetting_pass">
              パスワードを再設定する ▶ ︎
            </a>
          </p>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function(){
    return{
      errors: '',
      email: '',
      password: '',
      success_introduction: '',
      showContent: false,
      reset_password_token: '',
      confirmation_token: ''
    }
  },
  mounted: {
    function(){
      axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      };
    }
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
    setPass: function(event) {
      axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      };
      // 1.URLから (指定したパラメータ名~&|$|#) で終わる箇所を抜き出し
      const value = window.location.href.match(new RegExp("[?&]" + "confirmation_token" + "=(.*?)(&|$|#)"));
      // 2.パラメータ名に一致する値が存在しない場合は空返却
      if (value == null) return '';
      // 3.パラメータ名に一致する値が存在した場合はURLデコードして返却
      this.$data.confirmation_token = decodeURIComponent(value[1]);

      axios
        .patch('/users/confirmation', {password: this.password, confirmation_token: this.confirmation_token})
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
    }
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
