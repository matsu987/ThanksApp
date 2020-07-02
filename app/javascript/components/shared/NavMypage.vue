<template>
  <nav>
    <div class="header-top">
      <a href="/">
        <img class="header-top__logo" :src="this.current_user.avatar.url">
        <p class="header-top__text">{{ current_user.name }}</p>
      </a>
    </div>
    <div class="header-gNav">
      <ul>
        <li>
          <div>新規作成</div>
        </li>
        <li v-for='tab in tabs.mypage'>
          <NavBtn :current-tab-name="currentTab" :tab-name="tab.keyName" :url="tab.url" :text="tab.text" v-on:active="setActive"></NavBtn>
        </li>
      </ul>  
    </div>
  </nav>
</template>

<script>
import 'logo.png'
import axios from 'axios';
import NavBtn from 'components/shared/parts/NavBtn.vue';

export default {
  components: { NavBtn },
  data: function(){
    return {
      currentTab: "send",
      tabs: {
        mypage: {
          "send": {
            "text": "送信一覧",
            "keyName": "send",
            "url": "#"
          },
          "receive": {
            "text": "受信一覧",
            "keyName": "receive",
            "url": "#"
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
      }
    }
  },
  methods: {
    setActive: function(e){
      this.currentTab = e.text;
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
        console.log(this.$data.current_user)
      })
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
  }

  .header-gNav{
    width: 100%;
    height: 70vh;
  }

  .header-top__logo{
    width: 150px;
    height: 100px;
    padding: 20px 0;
  }

  .header-top__text{
    width: 200px;
    margin: 0 auto;
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
</style>
