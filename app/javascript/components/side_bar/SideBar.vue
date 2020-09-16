<template>
  <div id="side-bar">
    <div class="side-bar__header">
      <img src="~logo.png" class="side-bar__header__logo">
      <div class="side-bar__header__company">
        <img src="~company-logo.png" class="side-bar__header__company__logo">
        <div class="side-bar__header__company__info" v-cloak>
          <h3 class="side-bar__header__company__info__name" v-if="belong_to_company.company">{{belong_to_company.company.name}}</h3>
          <h3 class="side-bar__header__company__info__name" v-else>未所属</h3>
          <p class="side-bar__header__company__info__admin" v-if="belong_to_company.admin">管理者</p>
        </div>
      </div>
      <div class="side-bar__header__user" v-cloak>
        <img v-if="current_user.avatar" class="side-bar__header__user__img" :src="current_user.avatar.url">
        <img v-else class="side-bar__header__user__img" src="~avatar.png">
        <h3 class="side-bar__header__user__name">{{current_user.family_name}} {{current_user.given_name}}さん</h3>
      </div>
    </div>
    <button class="thanks-btn" @click="ThanksNew">新規作成</button>
    <ul class="side-bar__menu">
      <li class="side-bar__menu__list" v-bind:class="[ links.receive.active ? 'active-list' : '']">
        <a :href="links.receive.url" class="side-bar__menu__list__text" v-bind:class="[ links.receive.active ? 'active-text' : '']">受信一覧</a>
      </li>
      <li class="side-bar__menu__list" v-bind:class="[ links.send.active ? 'active-list' : '']">
        <a :href="links.send.url" class="side-bar__menu__list__text" v-bind:class="[ links.send.active ? 'active-text' : '']">送信一覧</a>
      </li>
      <li class="side-bar__menu__list" v-bind:class="[ links.account.active ? 'active-list' : '']">
        <a :href="links.account.url" class="side-bar__menu__list__text" v-bind:class="[ links.account.active ? 'active-text' : '']">アカウント設定</a>
      </li>
      <li class="side-bar__menu__list" v-bind:class="[ links.community.active ? 'active-list' : '']">
        <a :href="links.community.url" class="side-bar__menu__list__text" v-bind:class="[ links.community.active ? 'active-text' : '']">コミュニティ設定</a>
      </li>
      <li class="side-bar__menu__list" v-bind:class="[ links.admin.active ? 'active-list' : '']" v-if="belong_to_company.admin">
        <a :href="links.admin.url" class="side-bar__menu__list__text" v-bind:class="[ links.admin.active ? 'active-text' : '']">管理者設定</a>
      </li>
      <li class="side-bar__menu__list" v-bind:class="[ links.other.active ? 'active-list' : '']" >
        <a :href="links.other.url" class="side-bar__menu__list__text" v-bind:class="[ links.other.active ? 'active-text' : '']">その他</a>
      </li>
    </ul>
    
    <!-- 新規作成ポップアップ -->
    <div class="thanks-overlay" v-show="showThanksNew">
      <form class="form">
        <h2 class="form__title">新規作成</h2>
        <div class="flex">
          <div v-if= "thank.receiver.id" class="form__reciever" v-cloak>
            <img v-if="thank.receiver.avatar" class="form__reciever__img" :src="thank.receiver.avatar">
            <img v-else class="form__reciever__img" src="~avatar.png">
            <p class="form__reciever__name">To: {{thank.receiver.family_name + thank.receiver.given_name}}さん</p>
          </div>
          <button class="form__user-btn" @click="userSelectBtn" v-show="showUserSelectBtn">感謝を送りたい人を選択</button>
        </div>
        <textarea class="form__text" v-model="thank.text" type="text" placeholder="感謝を具体的に書きましょう"></textarea>
        <div class="form__sender" v-cloak>
          <img v-if="current_user.avatar" class="form__avatar" :src="current_user.avatar.url">
          <img v-else class="form__avatar" src="~avatar.png">
          <p class="form__sender__name">From: {{ current_user.family_name + current_user.given_name }}さん</p>
        </div>
        <div class="form__btn-box">
          <button class="form__btn-box__close" @click="closeThanksNew">保存せずに閉じる</button>
          <button class="form__btn-box__one-time" @click="createThank">一時保存</button>
          <button class="form__btn-box__confirm" @click="confirm">確定</button>
        </div>
      </form>
    </div>

    <!--ユーザー検索ポップアップ-->
    <div class="user-overlay" v-show="showUserSelect">
      <div class="user-overlay__box">
        <div class="groups-content">
          <h2 class="groups-content__title">グループから検索する</h2>
          <ul class="groups-content__result">
            <li v-for="(group, index) in groups" :key="group.id" @click="groupBox(index)" :data-id="group.id" ref="group" class="groups-content__result__box">
              <p v-if="!group.ancestry">{{group.name}}（コミュニティ全体）</p>
              <p v-else>{{group.name}}</p>
            </li>
          </ul>
        </div>
        <div class="arrow-content"></div>
        <div class="users-content">
          <input type="text" class="user-content__text" v-model="search_keyword" @input="onInput" placeholder="調整中">
          <ul class="users-content__result">
            <li v-for="(user, index) in searchUsers" :key="user.id" class="users-content__result__box" @click="userBox(index)" :data-id="user.id" :data-family-name="user.family_name" :data-given-name="user.given_name" :data-email="user.email" :data-avatar="user.avatar.url" ref="user">
              <img v-if="user.avatar.url" class="users-content__result__box__img" :src="user.avatar.url">
              <img v-else class="users-content__result__box__img" src="~avatar.png">
              <p class="users-content__result__box__name">{{user.family_name + user.given_name}}さん</p>
            </li>
          </ul>
        </div>
      </div>
      <div class="user-overlay__btn-box">
        <button class="close-btn" v-on:click="closeUserModal">Close</button>
      </div>
    </div>
    
    <!-- 投稿完了ポップアップ -->
    <div class="popup">
      <div class="overlay-finish" v-show="showfinishThanks">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li v-for="error in errors"><font color="red">{{ error }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">投稿が完了しました！</p>
          <button class="overlay-finish__close-btn" v-on:click="closefinishModal">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import 'logo.png';
import 'company-logo.png';
import 'avatar.png';

export default {
  data: function () {
    return {
      current_user: {},
      belong_to_company: {},
      links: {
        receive: {
          url: "",
          active: false,
        },
        send: {
          url: "",
          active: false,
        },
        account: {
          url: "",
          active: false,
        },
        community: {
          url: "",
          active: false,
        },
        admin: {
          url: "",
          active: false,
        },
        other: {
          url: "",
          active: false,
        },
      },
      showThanksNew: false,
      showUserSelect: false,
      showUserSelectBtn: true,
      showfinishThanks: false,
      thank: {
        text: '',
        transmission_status: false,
        receiver: {
          id: "",
          avatar: "",
          family_name: "",
          given_name: "",
        }
      },
      groups: [],
      users: [],
      search_keyword: "",
      searchData: {
        selectGroup: ""
      },
      searchUsers: [],
      errors: [],
    }
  },
  created() {
    // ログインユーザー取得
    axios
    .get('/api/users/login.json')
    .then(response => {
      if (response.status === 200 ) {
        this.$data.current_user = response.data

        let id = response.data.id

        this.$data.links.receive.url = `/users/${id}/letters/receive`
        this.$data.links.send.url = `/users/${id}/letters/send`
        this.$data.links.account.url = `/users/${id}/edit`
        this.$data.links.community.url = `/users/${id}/community`
        this.$data.links.admin.url = `/users/${id}/admin`
        this.$data.links.other.url = `/users/${id}/other`

        if (location.pathname == `/users/${id}/letters/receive`){
          this.$data.links.receive.active = true
        } else if (location.pathname == `/users/${id}/letters/send`) {
          this.$data.links.send.active = true
        } else if (location.pathname == `/users/${id}/edit`) {
          this.$data.links.account.active = true
        } else if (location.pathname == `/users/${id}/community`) {
          this.$data.links.community.active = true
        } else if (location.pathname == `/users/${id}/admin`) {
          this.$data.links.admin.active = true
        } else if (location.pathname == `/users/${id}/other`) {
          this.$data.links.other.active = true
        } else {
          this.$data.links.receive.active = true
        }
      }
    });

    // 所属しているコミュニティを取得
    let group_belong_url = `/api/users/${this.$data.current_user.id}/company/belong_to.json`;
    axios
    .get(group_belong_url)
    .then(response => {
      if (response.status === 200) {
        this.$data.belong_to_company = response.data
      }
    });
  },
  methods: {
    ThanksNew: function(e) {
      this.$data.showThanksNew = true
    },
    userSelectBtn: function(e) {
      e.preventDefault();
      this.$data.showUserSelect = true

      // 所属しているコミュニティのグループを取得
      let url = `/api/users/${this.$data.current_user.id}/groups.json`;
      axios
      .get(url, {params: {company_id: this.$data.belong_to_company.company.id}})
      .then(response => {
        this.$data.groups = response.data
      });
    },
    closeThanksNew: function(e) {

    },
    createThank: function(e) {
      e.preventDefault();
      let url = `/api/users/${this.$data.current_user.id}/thanks.json`;
      axios
        .post(url, this.thank)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            }
          this.$data.showfinishThanks = true
          this.$data.searchUsers = []
          this.$data.thank = {
                                id: '',
                                text: '',
                                receiver: {
                                  id: "",
                                  avatar: "",
                                  family_name: "",
                                  given_name: "",
                                  email: "",
                                },
                              }
          }
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });

    },
    confirm: function(e) {
      this.$data.thank.transmission_status = true
      this.createThank(e);
    },
    groupBox: function(e) {
      let selectGroupBox = this.$refs.group[e]
      this.$data.searchData.selectGroup = $(selectGroupBox).data("id")
      axios
        .get('/api/search/users.json', {params: this.searchData})
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
    onInput: function(e) {
      // axios
      //   .get('/search/users/index.json', {params: this.searchData})
      //   .then(response => {
      //     this.$data.searchUsers = []
      //     if (response.data.length){
      //       let users = response.data
      //       users.forEach(user => {
      //         this.$data.searchUsers.push(user);
      //       });
      //     }
      //   })
    },
    userBox: function(e) {
      let selectUserBox = this.$refs.user[e]
      this.$data.thank.receiver.id = $(selectUserBox).data("id")
      this.$data.thank.receiver.family_name = $(selectUserBox).data("family-name")
      this.$data.thank.receiver.given_name = $(selectUserBox).data("given-name")
      this.$data.thank.receiver.email = $(selectUserBox).data("email")
      this.$data.thank.receiver.avatar = $(selectUserBox).data("avatar")
      this.$data.userSelectbtn = false
      this.$data.showUserSelect = false
      console.log(this.$data)
    },
    closeUserModal: function(e) {
      e.preventDefault();
      this.$data.showUserSelect = false
    },
    closefinishModal: function(e) {
      e.preventDefault();
      this.$data.showfinishThanks = false
    }
  }
}
</script>

<style scoped>
  /* 共有 */

  [v-cloak] {
    display: none;
  }

  a {
    cursor: pointer;
  }

  img {
    display: block;
  }

  /* サイドバー */

  #side-bar {
    position: fixed;
    width: 300px;
    height: 100vh;
    background-color: #EDEDED;
    display: flex;
    flex-direction: column;
  }
  
  .side-bar__header {
    height: 290px;
    display: flex;
    flex-direction: column;
  }

  .side-bar__header__logo {
    width: 225px;
    margin: 0 auto;
  }

  .side-bar__header__company {
    display: flex;
    margin: 10px 43px;
  }

  .side-bar__header__company__logo {
    width: 65px;
  }

  .side-bar__header__company__info {
    padding-left: 13px;
  }

  .side-bar__header__company__info__name {
    font-weight: bold;
    font-size: 18px;
    color: #000000;

  }
  .side-bar__header__company__info__admin {
    color: #888888;
  }

  .side-bar__header__user {
    display: flex;
    margin: 10px 30px;
  }

  .side-bar__header__user__img {
    width: 90px;
    border-radius: 999px;
  }

  .side-bar__header__user__name {
    line-height: 75px;
    padding-left: 5px;
    font-size: 18px;
    color: #444444;
  }

  .thanks-btn {
    width: 180px;
    height: 40px;
    background: linear-gradient(121.55deg, #F9516F 11.31%, #FF8F6B 87.66%);
    border-radius: 18px;
    border-style: none;
    color: #fff;
    margin: 10px auto;
    cursor: pointer;
    font-size: 18px;
  }

  .side-bar__menu {
    height: calc(100% - 330px);
    position: relative;
    padding: 0 55px;
  }

  .side-bar__menu__list {
    margin: 30px 0;
    color: #444444
  }

  .side-bar__menu__list::before {
    content: "";
    position: absolute;
    border-radius: 999px;
    width: 35px;
    height: 35px;
    background: #C4C4C4;
  }

  .active-list::before {
    background: linear-gradient(121.55deg, #F9516F 11.31%, #FF8F6B 87.66%);
  }

  .side-bar__menu__list__text{
    margin-left: 60px;
    line-height: 35px;
  }

  .active-text {
    color: #ff0000de;
  }

 /* 新規作成ポップアップ */
  .thanks-overlay{
    max-width: 500px;
    width: 38%;
    height: 80%;
    z-index: 1;
    position: fixed;
    top: 10%;
    left: 400px;
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
    text-align: center;
  }

  .flex {
    display: flex;
  }

  .form__reciever {
    display: flex;
    margin: 15px 10px 10px 0;
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
    height: 45px;
    color: white;
    margin: 20px 0 20px 0;
  }

  .form__text {
    height: 50%;
    width: 100%;
    border: 1px solid #ff0000;
  }

  .form__sender {
    display: flex;
    justify-content: flex-end;
    margin: 10px 0;
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
    max-width: 600px;
    width: 50%;
    height: 83%;
    z-index: 1;
    position: fixed;
    top: 10%;
    left: 400px;
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
    width: 100%;
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
