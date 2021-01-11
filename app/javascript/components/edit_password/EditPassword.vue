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
                <p class="success-message" v-if="errors.length == 0 && successContent">パスワードの再設定が完了しました。<br><span class="sub-message">ログインして早速、感謝のメッセージを送りましょう。</span></p>
                <button class="btn btn-color-close btn-size-md btn-type-round" v-on:click="closeModal">Close</button>
              </div>
            </div>
          </div>
          <!-- パスワードリセットフォーム -->
          <div class="login-signup__box">
            <form action="/users/password" accept-charset="UTF-8" method="post" class="user-form" @submit.prevent="resetPass">
              <div class="user-form__box">
                <p style="font-size: 1.4rem;">こちらから新しいパスワードを設定してください。</p>
              </div>
              <div class="user-form__box">
                <input type="password" id="pass" placeholder="パスワード 英数字6文字以上" v-model="password" autocomplete="new-password" v-cloak>
              </div>
              <div class="user-form__btn">
                <input type="submit" name="commit" value="パスワードを確定する" class="login-btn btn btn-color-primary btn-size-md btn-type-round">
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

<!--
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
    <form @submit.prevent="resetPass">
      <div class="form_content">
        <div class="password_form">
          <label for="pass">PASS</label>
          <input autocomplete="on" type="password" id="pass" v-model="password" placeholder="6文字以上の半角英数字">
        </div>
      </div>
      <div class="form_bottom_content">
        <input type="submit" name="commit" value="パスワードを確定する">
          <p>
            <a href="/users/sign_in" class="resetting_pass">
              ログインページに戻る︎ ▶ ︎
            </a>
          </p>
      </div>
    </form>
  </div>-->
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
      confirmation_token: '',
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
      document.location.reload();
    },
    resetForm: function(){
      this.$data.email = ''
      this.$data.password = ''
    },
    resetPass: function(event) {
      axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      };
      // 1.URLから (指定したパラメータ名~&|$|#) で終わる箇所を抜き出し
      const value = window.location.href.match(new RegExp("[?&]" + "reset_password_token" + "=(.*?)(&|$|#)"));
      // 2.パラメータ名に一致する値が存在しない場合は空返却
      if (value == null) return '';
      // 3.パラメータ名に一致する値が存在した場合はURLデコードして返却
      this.$data.reset_password_token = decodeURIComponent(value[1]);
      axios
        .put('/users/password', {pass: this.pass, reset_password_token: this.reset_password_token, password: this.password})
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
main {
  width: 100%;
  padding: 0;
}
</style>
