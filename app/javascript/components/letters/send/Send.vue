<template>
  <div id="app" class="container">
    <SideBar></SideBar>
    <SendContents></SendContents>
  </div>
</template>

<script>
import axios from 'axios'
import SideBar from 'components/side_bar/SideBar.vue';
import SendContents from 'components/letters/send/SendContents.vue';

export default {
  components: {
    SideBar, SendContents
  },
  data: function () {
    return {
      mypageNav: "send"
    }
  }
}
</script>

<style scoped>
.container {
  display: flex;
}
header {
  width: 35%;
  height: 100vh;
  background-color: #fff;
  display: flex;
}
/* nav{
  width: 20%;
  height: 100vh;
  background-color: #EDEDED;
} */
main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
}
</style>
