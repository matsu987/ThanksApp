<template>
  <nav>
    <div class="header-top">
      <a href="/">
        <img class="header-top__logo" src="~logo.png">
        <p class="header-top__text">株式会社xxxxxxxx</p>
      </a>
    </div>
    <div class="header-gNav">
      <ul>
        <li v-for='tab in tabs.mypage'>
          <NavBtn :tab-name="tab" :text="tab.text"></NavBtn>          
        </li>
      </ul>  
    </div>
  </nav>
</template>

<script>
import 'logo.png'
import axios from 'axios';
import NavBtn from 'components/shared/NavBtn.vue';

export default {
  props: [ 'currentTab'],
  components: { NavBtn },
  created: function(){
    for ( const tab in this.tabs ){
      if (tab == this.headerTab){
        this.selectedTab = tab;
        console.log(this.selectedTab)
      }
    }
  },
  data: function(){
    return {
      headerTab: this.currentTab,
      selectedTab: "",
      tabs: {
        mypage: {
          "new": {
            "text": "新規作成"
          },
          "send": {
            "text": "送信一覧"  
          },
          "receive": {
            "text": "受信一覧"
          },
          "account": {
            "text": "アカウント設定"
          }
        },
        all: {
          "all": {
            "text": "全アリレター"
          },
          "data": {
            "text": "データ可視化"
          },
          "root": {
            "text": "管理者"
          }
        }
      }
    }
  },
  methods: {

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
