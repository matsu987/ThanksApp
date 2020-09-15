<template>
  <div id="app" class="container">
    <SideBar></SideBar>
    <ReceiveContents></ReceiveContents>
  </div>
</template>

<script>
import axios from 'axios'
import SideBar from 'components/side_bar/SideBar.vue';
import ReceiveContents from 'components/letters/receive/ReceiveContents.vue';

export default {
  components: {
    SideBar, ReceiveContents
  },
  data: function () {
    return {
      mypageNav: "receive"
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
