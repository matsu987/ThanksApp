<template>
  <div class="header">
    <a href="/">
      <img class="logo" src="~logo.png">
    </a>
    <a :href="myPageUrl">
      <div class="toggle_btn">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </a>
  </div>
</template>

<script>
import 'logo.png'
import axios from 'axios';

export default {
  data: function(){
    return {
      myPageUrl: '/',
    }
  },
  created() {
    console.log("test")
    axios
    .get('/users.json')
    .then(response => {
      this.$data.myPageUrl = `/users/${response.data.current_user.id}`
    });
  },
  methods: {
  }
}
</script>

<style scoped>
.toggle_btn span {
  display: block;
  position: absolute;
  right: 120px;
  width: 30px;
  height: 2px;
  background-color: orange;
  border-radius: 4px;
  transition: all .5s;
}
.toggle_btn span:nth-child(1) {
  top: 35px;
}
.toggle_btn span:nth-child(2) {
  top: 45px;
}
.toggle_btn span:nth-child(3) {
  top: 55px;
}
.header {
  position: relative;
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
