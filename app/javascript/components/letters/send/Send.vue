<template>
  <div id="app" class="container">
    <Header :nav="mypageNav"></Header>
    <SendContents></SendContents>
  </div>
</template>

<script>
import axios from 'axios'
import Header from 'components/shared/Header.vue';
import SendContents from 'components/letters/send/SendContents.vue';

export default {
  components: {
    Header, SendContents
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
