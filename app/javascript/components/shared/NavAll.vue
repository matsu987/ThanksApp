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
        <li v-for='tab in tabs.all'>
          <NavBtn :current-tab-name="currentTab" :tab-name="tab.keyName" :text="tab.text" v-on:active="setActive"></NavBtn>
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
  components: { NavBtn },
  data: function(){
    return {
      currentTab: "all",
      tabs: {
        all: {
          "all": {
            "text": "全アリレター",
            "keyName": "all"
          },
          "data": {
            "text": "データ可視化",
            "keyName": "data"
          },
          "root": {
            "text": "管理者",
            "keyName": "root"
          }
        }
      }
    }
  },
  methods: {
    setActive: function(e){
      this.currentTab = e.text;
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
