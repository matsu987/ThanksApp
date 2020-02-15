<template>
  <div id="app">
    <Header></Header>
    <div class="main-box">
      <SideBar></SideBar>
      <FormEdit></FormEdit>
    </div>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import SideBar from 'components/SideBar.vue';
import FormEdit from 'components/FormEdit.vue';

import 'flower.png'

export default {
  components: {
    Header,FormEdit,SideBar
  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
#app {
  background-image: url('~flower.png')
}
.main-box {
  display: flex;
  height: calc( 100vh - 100px);
  width: 100%;
}
p {
  font-size: 2em;
  text-align: center;
}
</style>
