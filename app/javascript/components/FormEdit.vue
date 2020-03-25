<template>
  <div class="form-box">
    <div class="thanks-notice">
      <p class="thanks-notice-message">
        「公開前」のサプライズサンクスは、総会日に一斉送信されます<br>
        「下書き」のままでは送信されませんので、必ず期日までに<span class="emphasis">更新する</span>ボタンを押してください！
      </P>
    </div>
    
    <transition enter-active-class="animated fadeInDown" leave-active-class="animated fadeOutUp">
      <div class="overlay" v-show="showContent">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li><font color="red">{{ e }}</font></li>
            </ul>
          </div>
          <p class="success-message"v-if="errors.length == 0">熱い感謝のメッセージを受け取りました！<br><span class="sub-message">期限までは投稿画面にて編集可能です。</span></p>
          <button class="close-btn" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </transition>
    
    <transition enter-active-class="animated fadeInDown" leave-active-class="animated fadeOutUp">
      <div class="overlay" v-show="deletePop">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li><font color="red">{{ e }}</font></li>
            </ul>
          </div>
          <p class="success-message-delete">感謝のメッセージを削除しました！</p>
          <a href="/thanks/new">
            <button class="close-btn" >Close</button>
          </a>
        </div>
      </div>
    </transition>
    

    <!-- 編集用フォーム-->
    <form @submit.prevent="updateThank">
      <div class="thanks-form">
        <div class="thanks-form-box">
          <div class="receiver-select">
            <img v-if="receiver.avatar" class="receiver_icon" :src="receiver.avatar">
            <img v-else class="receiver_icon" src="~person.png">
            <p class="receiver-text">To: {{ receiver.user.name}} さん</p>
            <input class="receiver_id hidden" v-model="thank.receiver_id" type="text">
          </div>
          <textarea class="thanks-message" v-model="thank.text" type="text"></textarea>
          <div class="sender-select">
            <img v-if="current_user.avatar" class="login-icon" :src="current_user.avatar">
            <img v-else class="login-icon" src="~person.png">
            <p class="sender-text">From: {{ current_user.user.name }}</p>
          </div>
        </div>
      </div>
      <div class="form-btn">
        <a href="/thanks/new">
          <button class="return-btn" type="button">戻る</button>
        </a>
        <div class="form-submit">
          <button class="delete-btn" type="button" @click="thanksDelete">削除する</button>
          <button class="confirm-btn" type="submit">更新する</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import 'person.png'

var editUrl = location.pathname + '.json'


export default {
  props: ["sidebarThanks"],
  data: function () {
    return {
      form: true,
      current_user: {},
      receiver: {},
      thank: {},
      errors: '',
      showContent: false,
      updateUrl: '',
      deletePop: false
    }
  },
  created() {
    axios
    .get(editUrl)
    .then(response => {
      console.log(response)
     this.$data.current_user = response.data.current_user
     this.$data.receiver = response.data.receiver
     this.$data.thank = response.data.thank
     this.$data.updateUrl = "/thanks/" + response.data.thank.id + '.json'
    });
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  },
  methods: {
    thanksDelete: function(){
      var deleteUrl = "/thanks/" + this.$data.thank.id + '.json'
      axios
        .delete(deleteUrl)
        .then(response => {
          this.$data.deletePop = true
        });

    },
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
    },
    resetForm: function(){
      this.$data.thank.receiver_id = ''
      this.$data.thank.text = ''
    },
    sidebarUpdate: function(){
      axios
      .get('/thanks.json')
      .then(response => {
        var thanks = response.data.send_thanks
        this.sidebarThanks.thanks = thanks
        this.sidebarThanks.receivers = response.data.receivers

        var array = []

        thanks.forEach(thank => {
          var url = "/thanks/" + thank.id + "/edit"
          array.push(url);
        });
        this.sidebarThanks.editUrls = array
        this.$emit("side-update", this.sidebarThanks)
      });
    },
    updateThank: function(event) {
      axios
        .patch(this.updateUrl, this.thank)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
          }

          } else {

            let e = response.data;
          }
          this.sidebarUpdate();
          this.openModal();
        })
        .catch(error => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  }
}
</script>

<style scoped>
.form-box {
  position: absolute;
  width: calc( 100% - 550px);
  left: 430px;
}

.thanks-form {
  height: 500px;
  background: #FFFFFF;
  opacity: 0.8;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.25);
}

.thanks-form-box {
  width: 80%;
  margin: 20px auto;
  height: 100%;
}

.receiver-select{
  display: flex;
  margin-top: 10px;
}

.receiver-text{
  line-height: 90px;
  font-weight: bold;
  color: black;
}

.receiver-input{
  display: block;
  height: 30px;
  margin-top: 25px;
}

.thanks-message{
  width: 100%;
  height: 63%;
}

.sender-select{
  width: 220px;
  display: flex;
  margin-left: auto;
}

.sender-text{
  line-height: 80px;
  font-weight: bold;
  color: black;
}

.sender-input{
  display: block;
  height: 30px;
  margin-top: 25px;
}

.form-btn{
  display: flex;
  position: relative;
  margin: 30px;
}

.form-submit {
  position: absolute;
  right: 0;
}

.return-btn {
  background: #C4C4C4;
  color: #fff;
}

.draft-btn {
  background: #FFFFFF;
  border: 2px solid #ADDCD9;
  box-sizing: border-box;
  color: #ADDCD9;
}

.confirm-btn {
  background: #ADDCD9;
  color: #fff;
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

.success-message-delete {
  display: block;
  margin-bottom: 40px;
  padding-top: 40px;
  font-size: 20px;
  color: red;
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

.hidden {
  display: none;
}

.delete-btn {
  background: red;
  color: #fff;
}

p {
  font-size: 14PX;
  color: red;
}

.emphasis {
  font-weight: bold;
  font-size: 20px;
}

img {
  height: 80px;
  width: 80px;
  border-radius: 999px;
}

button {
  width: 120px;
  height: 40px;
  border-radius: 40px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.receiver_icon {
  margin: 5px 5px;
}

.login-icon {
  margin-right: 5px;
}
</style>
