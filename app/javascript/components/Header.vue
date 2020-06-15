<template>
  <div class="header">
    <a href="/">
      <img class="logo" src="~logo.png">
    </a>
    <!-- <a :href="myPageUrl"> -->
      <div v-on:click="openMenu" v-show="menu" class="toggle_btn">
        <span></span>
        <span></span>
        <span></span>
      </div>
    <!-- </a> -->
    <SideBar v-show="sideBar" v-on:closeMenu="onCloseMenu"></SideBar>
  </div>
</template>

<script>
import 'logo.png'
import axios from 'axios';
import SideBar from 'components/side_bar/SideBar.vue';

export default {
  components: { SideBar },
  data: function(){
    return {
      myPageUrl: '/',
      sideBar: false,
      menu: true
    }
  },
  created() {
    axios
    .get('/users.json')
    .then(response => {
      this.$data.myPageUrl = `/users/${response.data.current_user.id}`
    });
  },
  methods: {
    openMenu: function(){
      this.sideBar = true
      this.menu = false
    },
    onCloseMenu: function(e){
      this.sideBar = false
      this.menu = true
    }
  }
}
</script>

<style scoped>
.toggle_btn{
  height: 30px;
  width: 30px;
  position: absolute;
  right: 120px;
  top: 35px;
  width: 30px;
}
.toggle_btn span {
  display: block;
  height: 2px;
  background-color: orange;
  border-radius: 4px;
  transition: all .5s;
}
.toggle_btn span:nth-child(1) {
  margin-bottom: 8px;
}
.toggle_btn span:nth-child(2) {
  margin-bottom: 8px;
}

.header {
  width: 100%;
  height: 100px;
  background-color: #fff;
}

.logo {
  position: absolute;
  top: 25px;
  left: 120px;
  height: 50px;
}

.mypage-btn {
  position: absolute;
  top: 70px;
  right: 150px;
}
.logout-btn {
  position: absolute;
  top: 70px;
  right: 50px;
}
p {
  font-size: 2em;
  text-align: center;
}
</style>
