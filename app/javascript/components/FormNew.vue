<template>
  <div class="form-box">
    <div class="thanks-notice">
      <p class="thanks-notice-message">
        「確定済み」のサプライズサンクスは、総会日に一斉送信されます<br>
        「下書き」のままでは送信されませんので、必ず期日までに<span class="emphasis">確定する</span>ボタンを押してください！
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
    <!-- 投稿用フォーム-->
    <form @submit.prevent="createThank">
      <div class="thanks-form">
        <div class="thanks-form-box">
          <div class="receiver-select">
            <img class="logo" src="~person.png">
            <p class="receiver-text">To: </p>
            <!--<input class="receiver-input" v-model="thank.receiver_name" type="text">-->
            <input class="receiver_id receiver-input" v-model="keyword" @click="userSelect" @keydown.enter="userSelect" @input="onInput" @keyup="onInput" type="text" autocomplete="on" list="user">
            <div id="user-search-result">
              <datalist id="user">
                <option v-for="(user, index) in searchUsers" :key="user.id">{{user.name}}</option>
              </datalist>
              <p class="receiver-text">さん</p>
            </div>
          </div>
          <textarea class="thanks-message" v-model="thank.text" type="text"></textarea>
          <div class="sender-select">
            <img class="logo" src="~person.png">
            <p class="sender-text">From: {{ current_user.name }}</p>
          </div>
        </div>
      </div>
      <div class="form-btn">
        <div class="form-submit">
          <button class="confirm-btn" type="submit">保存する</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import 'person.png'

export default {
  props: ["sidebarThanks"],
  data: function () {
    return {
      current_user: {},
      thank: {
        id: '',
        receiver_id: '',
        text: '',
      },
      receiver: {},
      errors: '',
      showContent: false,
      keyword: '',
      searchUsers: []
    }
  },
  created() {
    axios
    .get('/thanks.json')
    .then(response => {
      this.$data.current_user = response.data.current_user
    });
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  },
  methods: {
    userSelect: function(e){
      e.preventDefault();
    },
    onInput: function(){
      axios
        .get('/search/users/index.json', {params: this.keyword})
        .then(response => {
          this.$data.searchUsers = []
          var userSearchResult = document.getElementById('user-search-result');
            var noUser = document.getElementById("no-user")
            if (noUser){
              document.getElementById("no-user").remove();
            }
          if (response.data.length !== 0){
            var users = response.data
            var array = this.$data.searchUsers

            users.forEach(user => {
              array.push(user);
            });
          } else {
            userSearchResult.insertAdjacentHTML('beforebegin','<p id="no-user" style="width: 182px; height: 50px; position: absolute; top: 60px; left: 103px; border: solid 0.5px black; line-height: 50px; padding-left: 5px; font-weight: bold; background: black; color: #fff; font-size: 11px; border-radius: 0.2em;">ユーザーが見つかりませんでした</p>');
          }
        })
    },
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
    },
    resetForm: function(){
      this.$data.keyword = ''
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
    createThank: function(event) {
      var users = this.$data.searchUsers

      users.forEach(user => {
        if (user.name === this.keyword){
          this.$data.thank.receiver_id = `${user.id}`;
        }
      });

      axios
        .post('/thanks.json', this.thank)
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
          this.resetForm();
          this.$data.searchUsers = []
        })
        .catch(error => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
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
  position: relative;
}

.receiver-text{
  line-height: 80px;
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
  height: 65%;
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
}

button {
  width: 120px;
  height: 40px;
  border-radius: 40px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

#test {
  
}
</style>
