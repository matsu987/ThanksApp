<template>
  <main id="app" class="container">
    <div class="main-contents" v-cloak>
      <div class="main-header">
        <img class="ari-logo" src="~login/ari-logo.png">
      </div>
      <div class="main-box">
        <div class="main-box__img">
          <img class="pc-img" src="~login/pc.png">
        </div>
        <div class="login-signup__content">
          <!-- ポップアップ-->
          <div class="login-popup">
            <div class="overlay" v-show="showContent">
              <div class="content">
                <div class="error-message" v-if="errors.length != 0">
                  <ul v-for="e in errors" :key="e">
                    <li><font color="red">{{ e }}</font></li>
                  </ul>
                </div>
                <p class="success-message" v-show="waitContent">パスワード再設定用のメールをお送りしています。<br>しばらくお待ちください。</p>
                <p class="success-message" v-if="errors.length == 0 && successContent">パスワード再設定用のメールをお送り致しました。<br><span class="sub-message">メールのご確認をよろしくお願い致します。</span></p>
                <button class="btn btn-color-close btn-size-md btn-type-round" v-on:click="closeModal">Close</button>
              </div>
            </div>
          </div>
          <!-- パスワードリセットフォーム -->
          <div class="login-signup__box">
            <form action="/users/password" accept-charset="UTF-8" method="post" class="user-form" @submit.prevent="createPass">
              <div class="user-form__box">
                <p style="font-size: 1.4rem;">パスワードをお忘れの場合は登録メールアドレスを入力して入力してパスワードの再設定を行ってください。<br>
                パスワード再設定用のメールをお送りします。</p>
              </div>
              <div class="user-form__box">
                <input type="email" id="email" v-model="email" placeholder="メールアドレス" v-cloak>
              </div>
              <div class="user-form__btn">
                <input type="submit" name="commit" value="認証メールを送信する" class="login-btn btn btn-color-primary btn-size-md btn-type-round">
              </div>
              <div class="user-form__help">
                <img class="user-form__help-icon" src="~login/help.png" alt="ヘルプマーク">
                <a href="/" class="user-form__help-txt">
                  ログインページに戻る︎
                </a>
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

export default {
  data: function(){
    return{
      errors: '',
      email: '',
      password: '',
      success_introduction: '',
      showContent: false,
      waitContent: false,
      successContent: false,
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
      this.$data.waitContent = false
      this.$data.successContent = false
    },
    resetForm: function(){
      this.$data.email = ''
      this.$data.password = ''
    },
    createPass: function(event) {
      this.openModal();
      this.$data.waitContent = true
      axios
        .post('/users/password', {email: this.email})
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors_introduction) {
            this.errors = response.data.errors_introduction;
            }
            else{
              this.$data.successContent = true
              this.success_introduction = response.data.success_introduction;
              this.openModal();
            }
          } else {
            let e = response.data;
          }
          this.$data.waitContent = false
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
main {
  width: 100%;
  padding: 0;
}
</style>
