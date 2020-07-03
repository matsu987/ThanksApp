<template>
  <div id="app" class="container">
    <Header :nav="mypageNav"></Header>
    <Contents></Contents>
  </div>
</template>

<script>
import axios from 'axios'
import Header from 'components/shared/Header.vue';
import Contents from 'components/shared/Contents.vue';

export default {
  components: {
    Header, Contents
  },
  data: function () {
    return {
      mypageNav: "send"
    }
  },
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

main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
}
</style>
