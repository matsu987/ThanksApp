<template>
  <header>
    <div class="header-box">
      <div class="header-top">
        <a href="/">
          <img class="header-top__logo" src="~logo.png">
          <p class="header-top__text">株式会社xxxxxxxx</p>
        </a>
      </div>
      <div class="header-gNav">
        <ul>
          <li v-for="tab in tabs">
            <!-- 現在のheaderTabの名前("mypageなど")、NavBtnに渡すtabの名前、NavBtnに渡すtabのテキストをpropで送る -->
            <!-- emitでNavBtnにてクリックした後headerTabの変更を監視 -->
            <!-- setActiveでheaderTabの変更をしてtoppageにemitで送る -->
            <NavBtn :current-tab-name="headerTab" :tab-name="tab.keyName" :text="tab.text" v-on:active="setActive"></NavBtn>
          </li>
        </ul>
      </div>
    </div>
    <Nav></Nav>
    <components :is="currentNav"></components>
  </header>
</template>

<script>
import 'logo.png'
import axios from 'axios'
import Nav from 'components/shared/Nav.vue';
import NavBtn from 'components/shared/NavBtn.vue';
// import ActNavBtn from 'components/shared/ActNavBtn.vue';

export default {
  components: { Nav, NavBtn},
  props: [ 'currentTab' ],
  data: function(){
    return {




      
      headerTab: this.currentTab,
      tabs: {
        "mypage": {
          "text": "マイページ",
          "keyName": "mypage"
        },
        "all": {
          "text": "全社員",
          "keyName": "all"
        }
      }
    }
  },
  created: function () {
      console.log(this.currentTab);
    },
  computed:{

  },
  methods: {
    setActive: function(e){
      this.headerTab = e.text;
      this.$emit('change', this.headerTab)
    }
  }
}
</script>

<style scoped>
  ul{
    list-style: none;
  }

  .header-box{
    display: flex;
    flex-direction: column;
    text-align: center;
    width: 40%;
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
