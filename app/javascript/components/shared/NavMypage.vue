<template>
  <nav>
    <div class="header-top">
      <a href="/">
        <img class="header-top__logo" :src="current_user.avatar.url">
        <p class="header-top__text">{{ current_user.family_name }} {{ current_user.given_name }}</p>
      </a>
    </div>
    <div class="header-gNav">
      <ul>
        <li>
          <div class="new" @click="newThanks">新規作成</div>
        </li>
        <li v-for='tab in tabs.mypage'>
          <NavBtn :current-tab-name="currentTab" :tab-name="tab.keyName" :url="tab.url" :text="tab.text" v-on:active="setActive"></NavBtn>
        </li>
      </ul>
    </div>

    <!--  新規作成ポップアップ -->
    <div class="overlay" v-show="showContent">
      <form class="form">
        <h2 class="form__title">新規作成</h2>
        <div v-if= "thank.receiver_id" class="form__reciever">
          <img v-if="thank.receiver_avatar" class="form__reciever__img" :src="thank.receiver_avatar">
          <img v-else class="form__reciever__img" src="~person.png">
          <p class="form__reciever__name">To: {{thank.receiver_family_name + thank.receiver_given_name}}さん</p>
        </div>
        <button class="form__user-btn" @click="userSelect" v-show="userSelectbtn">感謝を送りたい人を選択</button>
        <textarea class="form__text" v-model="thank.text" type="text" placeholder="感謝を具体的に書きましょう"></textarea>
        <div class="form__sender">
          <img v-if="current_user.avatar.url" class="form__avatar" :src="current_user.avatar.url">
          <img v-else class="form__avatar" src="~person.png">
          <p class="form__sender__name">From: {{ current_user.family_name + current_user.given_name }}</p>
        </div>
        <div class="form__btn-box">
          <button class="form__btn-box__close">保存せずに閉じる</button>
          <button class="form__btn-box__one-time" @click="createThank">一時保存</button>
          <button class="form__btn-box__confirm" @click="confirm">確定</button>
        </div>
      </form>
    </div>

    <!-- ユーザー検索ポップアップ-->
    <div class="user-overlay" v-show="showUserSelect">
      <div class="user-overlay__box">
        <div class="groups-content">
          <h2 class="groups-content__title">グループから検索する</h2>
          <ul class="groups-content__result">
            <li v-for="(group, index) in groups" :key="group.id" @click="groupBox(index)" :data-id="group.id"  ref="group" class="groups-content__result__box">{{group.name}}</li>
          </ul>
        </div>
        <div class="arrow-content"></div>
        <div class="users-content">
          <input type="text" class="user-content__text" v-model="searchData.keyword" @input="onInput" placeholder="名前で検索する">
          <ul class="users-content__result">
            <li v-for="(user, index) in searchUsers" :key="user.id" class="users-content__result__box" @click="userBox(index)" :data-id="user.id" :data-family-name="user.family_name" :data-given-name="user.given_name" :data-email="user.email" :data-avatar="user.avatar.url" ref="user">
              <img v-if="user.avatar.url" class="users-content__result__box__img" :src="user.avatar.url">
              <img v-else class="users-content__result__box__img" src="~person.png">
              <p class="users-content__result__box__name">{{user.family_name + user.given_name}}さん</p>
            </li>
          </ul>
        </div>
      </div>
      <div class="user-overlay__btn-box">
        <button class="close-btn" v-on:click="closeUserModal">Close</button>
        <button class="select-btn" v-on:click="closeUserModal">宛先を決定</button>
      </div>
    </div>
    
    <!-- 投稿完了ポップアップ-->
    <div class="popup">
      <div class="overlay-finish" v-show="showfinishContent">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li><font color="red">{{ errors }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">投稿が完了しました！</p>
          <button class="overlay-finish__close-btn" v-on:click="closefinishModal">Close</button>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
import 'logo.png'
import axios from 'axios';
import NavBtn from 'components/shared/parts/NavBtn.vue';

export default {
  components: { NavBtn },
  props: ["nav"],
  data: function(){
    return {
      currentTab: this.nav,
      errors: '',
      showContent: false,
      tabs: {
        mypage: {
          "send": {
            "text": "送信一覧",
            "keyName": "send",
            "url": "/users/1/letters/send"
          },
          "receive": {
            "text": "受信一覧",
            "keyName": "receive",
            "url": "/users/1/letters/receive"
          },
          "account": {
            "text": "アカウント設定",
            "keyName": "account",
            "url": "/users/1/edit"
          },
          "group": {
            "text": "グループ設定",
            "keyName": "group",
            "url": "/groups/new"
          }
        }
      },
      current_user: {
        name: null,
        avatar: {
          url: ""
        }
      },
      thank: {
        id: '',
        text: '',
        receiver_id: '',
        receiver_family_name: '',
        receiver_given_name: '',
        receiver_email: '',
        receiver_avatar: '',
        transmission_status: false
      },
      showUserSelect: false,
      userSelectbtn: true,
      searchUsers: [],
      groups: [],
      searchData: {
        selectGroup: "",
        keyword: '',
      },
      showfinishContent: false,
    }
  },
  methods: {
    setActive: function(e){
      this.currentTab = e.text;
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
    closefinishModal: function(){
      this.$data.showfinishContent = false
      this.$data.showContent = false
      document.location.reload()
    },
    newThanks: function(e){
      this.openModal();
    },
    userSelect: function(e){
      e.preventDefault();
      this.$data.showUserSelect = true
      axios
        .get('/search/groups/index.json')
        .then(response => {
          this.$data.groups = response.data
        })
    },
    groupBox: function(e) {
      // eは選択されたグループの配列番号
      let selectGroupBox = this.$refs.group[e]
      this.$data.searchData.selectGroup = $(selectGroupBox).data("id")
      axios
        .get('/search/users/index.json', {params: this.searchData})
        .then(response => {
          this.$data.searchUsers = []
          if (response.data.length){
            let users = response.data
            users.forEach(user => {
              this.$data.searchUsers.push(user);
            });
          }
        })
    },
    userBox: function(e) {
      let selectUserBox = this.$refs.user[e]
      this.$data.thank.receiver_id = $(selectUserBox).data("id")
      this.$data.thank.receiver_family_name = $(selectUserBox).data("family-name")
      this.$data.thank.receiver_given_name = $(selectUserBox).data("given-name")
      this.$data.thank.receiver_email = $(selectUserBox).data("email")
      this.$data.thank.receiver_avatar = $(selectUserBox).data("avatar")
      this.$data.userSelectbtn = false
    },
    onInput: function(e) {
      axios
        .get('/search/users/index.json', {params: this.searchData})
        .then(response => {
          this.$data.searchUsers = []
          if (response.data.length){
            let users = response.data
            users.forEach(user => {
              this.$data.searchUsers.push(user);
            });
          }
        })

    },
    confirm: function(e){
      this.$data.thank.transmission_status = true
      this.createThank(e);
    },
    createThank: function(e) {
      e.preventDefault();
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
          this.$data.showfinishContent = true
          this.$data.searchUsers = []
          this.$data.thank = {
                                id: '',
                                text: '',
                                receiver_id: '',
                                receiver_family_name: '',
                                receiver_given_name: '',
                                receiver_email: '',
                                receiver_avatar: '',
                              }
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  },
  created(){
      axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      };
      axios
      .get('/thanks.json')
      .then( response => {
        this.$data.current_user = response.data.current_user
        this.tabs.mypage.send.url = "/users/" + response.data.current_user.id + "/letters/send"
        this.tabs.mypage.receive.url = "/users/" + response.data.current_user.id + "/letters/receive"
        this.tabs.mypage.account.url = "/users/" + response.data.current_user.id + "/edit"
      })
  },
  computed: {
    receive_url: function(){
      
    }
  }
}
</script>

<style scoped>
  ul{
    list-style: none;
  }

  nav{
    display: flex;
    flex-direction: column;
    text-align: center;
    width: 60%;
    background: #EDEDED;
  }

  .header-top{
    width: 100%;
    padding: 15px 0;
    height: 300px;
  }

  .header-gNav{
    width: 100%;
    height: 70vh;
  }

  .header-top__logo{
    width: 100px;
    padding: 20px 0;
  }

  .header-top__text{
    width: 200px;
    margin: 0 auto;
  }

  .new{
    background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
    border-radius: 18px;
    width: 180px;
    height: 35px;
    color: white;
    margin: 0 auto 20px;
    line-height: 35px;
  }
  .gNav-section__link{
    display: flex;
    width: 80%;
    margin: 0 auto;
  }
  .gNav-section__btn{
    background-color: #B1B1B1;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin: 0 14px 25px 0;
  }

  /* 新規作成ポップアップ */
.overlay{
  width: 38%;
  height: 90%;
  z-index: 1;
  position: fixed;
  top: 4%;
  left: 48%;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
  box-sizing: border-box;
  display: flex;
  justify-content: center;
}

.form {
  width: 80%;
}

.form__title {
  margin: 20px 0;
  color: #ff0000;
}

.form__reciever {
  display: flex;
  margin: 10px 50px 10px 0;
}

.form__reciever__img {
  height: 50px;
  width: 50px;
  border-radius: 999px;
}

.form__reciever__name {
  line-height: 50px;
  margin-left: 10px;
}

.form__user-btn {
  display: block;
  background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border-radius: 18px;
  border: none;
  width: 30%;
  height: 45px;
  color: white;
  margin: 20px 0 20px 0;
}

.form__text {
  height: 60%;
  width: 100%;
  border: 1px solid #ff0000;
}

.form__sender {
  display: flex;
  justify-content: flex-end;
  margin: 10px 50px 10px 0;
}

.form__avatar {
  height: 50px;
  width: 50px;
  border-radius: 999px;
}

.form__sender__name {
  line-height: 50px;
  margin-left: 10px;
}

.form__btn-box {
  display: flex;
  justify-content: flex-end;
}

.form__btn-box__close {
  display: block;
  border-radius: 18px;
  background: #fff;
  border: 2px solid #BDBDBD;
  width: 50%;
  height: 70px;
  color: #BDBDBD;

}

.form__btn-box__one-time {
  display: block;
  border-radius: 18px;
  border: 2px solid #ff0000;
  background: #fff;
  width: 35%;
  height: 70px;
  color: #ff0000;
  margin: 0 10px;
}

.form__btn-box__confirm {
  display: block;
  background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border-radius: 18px;
  border: none;
  width: 25%;
  height: 70px;
  color: white;
}

/* ユーザー検索 */
.user-overlay{
  width: 50%;
  height: 83%;
  z-index: 1;
  position: fixed;
  top: 10%;
  left: 41%;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
  align-items: center;
  justify-content: center;
}

.user-overlay__box {
  display: flex;
  height: 90%;
  padding: 20px;
}

.groups-content {
  height: 100%;
  width: 40%;
}

.groups-content__title {
  margin-bottom: 20px;
}

.groups-content__result {
  height: 90%;
  background: #FAFAFA;
  overflow: scroll;
}

.groups-content__result__box {
  padding-top: 10px;
}

.arrow-content {
  height: 100%;
  width: 20%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.arrow-content::after {
  content: "⇨";
  font-size: 45px;
  color: gray;
}
.users-content {
  height: 100%;
  width: 40%;
}

.user-content__text {
  margin-bottom: 20px;
  border: dotted 1px gray;
}

.users-content__result {
  height: 90%;
  background: #FAFAFA;
}

.users-content__result__box {
  display: flex;
  padding: 10px 0 0 10px;
}

.users-content__result__box__img {
  width: 40px;
  border-radius: 999px;
}

.users-content__result__box__name {
  line-height: 40px;
  padding-left: 5px;
}

.user-overlay__btn-box {
  display: flex;
  justify-content: space-between;
}

.close-btn {
  display: block;
  border-radius: 18px;
  background: #fff;
  border: 2px solid #BDBDBD;
  margin-left: 20px;
  width: 37%;
  height: 45px;
  color: #BDBDBD;
}

.select-btn {
  display: block;
  background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border-radius: 18px;
  border: none;
  margin-right: 20px;
  width: 37%;
  height: 45px;
  color: white;
}

/* 投稿完了ポップアップ */
.overlay-finish{
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

.overlay-finish__close-btn {
  display: block;
  margin: auto;
  width: 200px;
  height: 50px;
  border-radius: 25px;
  border: none;
}
</style>
