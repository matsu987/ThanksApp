<template>
  <div class="form-box">
    <div class="thanks-notice">
      <p class="thanks-notice-message">
        「公開前」のサプライズサンクスは、総会日に一斉送信されます<br>
        「下書き」のままでは送信されませんので、必ず期日までに<span class="emphasis">保存する</span>ボタンを押してください！
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
    <!-- ユーザー検索ポップアップ -->
    <transition enter-active-class="animated fadeInDown" leave-active-class="animated fadeOutUp">
      <div class="user-overlay" v-show="showUserSelect">
        <div class="user-content">
          <div class="side-content">
            グループ一覧
            <div class="groups">
              <ul>
                <li v-for="(group, index) in groups" :key="group.id" @click="groupBox(index)" :data-id="group.id"  ref="group" class="group-list">{{group.name}}</li>
              </ul>
            </div>
          </div>
          <div class="main-content">
            <input type="text" v-model="searchData.keyword" @input="onInput" class="user-input">
            <div id="user-search-result">
              <ul class="users-box">
                <li v-for="(user, index) in searchUsers" :key="user.id" class="user-box" @click="userBox(index)" :data-id="user.id" :data-name="user.name" :data-avatar="user.avatar.url" ref="user">
                  <img v-if="user.avatar.url" class="logo-small" :src="user.avatar.url">
                  <img v-else class="logo-small" src="~person.png">
                  <p class="user-name">{{user.name}}さん（{{user.email}}）</p>
                </li>
              </ul>
              <p class="receiver-text"></p>
            </div>
          </div>
        </div>
        <button class="close-btn" v-on:click="closeUserModal">Close</button>
      </div>
    </transition>
    <!-- 投稿用フォーム-->
    <form @submit.prevent="createThank">
      <div class="thanks-form">
        <div class="thanks-form-box">
          <div class="receiver-select">
            <div v-if= "thank.receiver_id" class="receiver-box">
              <img v-if="thank.receiver_avatar" class="logo-small" :src="thank.receiver_avatar">
              <img v-else class="logo-small" src="~person.png">
              <p class="user-name">{{thank.receiver_name}}さん</p>
            </div>
            <button type="button" @click="userSelect">感謝を送りたい人を選択</button>
          </div>
          <textarea class="thanks-message" v-model="thank.text" type="text"></textarea>
          <div class="sender-select">
            <img v-if="avatar" class="logo" :src="avatar">
            <img v-else class="logo" src="~person.png">
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
      avatar: '',
      thank: {
        id: '',
        text: '',
        receiver_id: '',
        receiver_name: '',
        receiver_avatar: ''
      },
      receiver: {},
      errors: '',
      showContent: false,
      showUserSelect: false,
      searchUsers: [],
      groups: [],
      searchData: {
        selectGroup: "",
        keyword: '',
      }
    }
  },
  created() {
    axios
    .get('/users.json')
    .then(response => {
      this.$data.current_user = response.data.current_user
      this.$data.avatar = response.data.avatar
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
      this.$data.showUserSelect = true
      axios
        .get('/search/groups/index.json')
        .then(response => {
          this.$data.groups = response.data
        })
    },
    onInput: function(){
      axios
        .get('/search/users/index.json', {params: this.searchData})
        .then(response => {
          this.$data.searchUsers = []
          var userSearchResult = document.getElementById('user-search-result');
          if (response.data.length !== 0){
            var users = response.data
            this.$data.searchUsers = []
            users.forEach(user => {
              this.$data.searchUsers.push(user);
            });
          }
        })
    },
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
    },
    closeUserModal: function(){
      this.$data.showUserSelect = false
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
          this.$data.thank = {
                                id: '',
                                text: '',
                                receiver_id: '',
                                receiver_name: '',
                                receiver_avatar: ''
                              }
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    userBox: function(e) {
      // eは選択されたユーザーの配列番号
      let selectUserBox = this.$refs.user[e]
      this.$data.thank.receiver_id = $(selectUserBox).data("id")
      this.$data.thank.receiver_name = $(selectUserBox).data("name")
      this.$data.thank.receiver_avatar = $(selectUserBox).data("avatar")
      this.closeUserModal();
    },
    groupBox: function(e) {
      // eは選択されたグループの配列番号
      let selectGroupBox = this.$refs.group[e]
      this.$data.searchData.selectGroup = $(selectGroupBox).data("id")
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
  padding-left: 5px;
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

.user-overlay{
  width: 50%;
  height: 50%;
  z-index: 1;
  position: fixed;
  top: 25%;
  left: 25%;
  background-color: #fff;
  border: 2px solid #555555;
  box-sizing: border-box;
  align-items: center;
  justify-content: center;
}

.close-btn {
  display: block;
  margin: 0 auto;

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
  border-radius: 999px;
}

button {
  width: 120px;
  height: 40px;
  border-radius: 40px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.user-content {
  display: flex;
  width: 100%;
  height: 85%;
  padding: 10px 0;
}

.side-content {
  width: 30%;
  height: 100%;
  text-align: center;
}

.main-content {
  width: 70%;
  height: 100%;
}

.logo-small {
  width: 50px;
  height: 50px;
}

.users-box {
  overflow: scroll;
}

.user-box {
  display: flex;
  padding: 10px;
  border-bottom: solid 1px black;
}

.user-name {
  line-height: 40px;
  margin-left: 10px;
  color: black;
}

.group-list {
  padding: 10px;
  border-bottom: solid 1px black;
}

#user-search-result {
  height: 85%;
  width: 80%;
  margin: 15px auto;
  border: solid 1px black;
}

.user-input {
  display: block;
  margin: 0 auto;
}

.receiver-box {
  display: flex;
}
</style>
