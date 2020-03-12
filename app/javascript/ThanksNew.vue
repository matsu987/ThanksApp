<template>
  <div id="app">
    <Header></Header>
    <div class="main-box">
      <SideBar v-bind:sidebar-thanks="sidebarThanks"></SideBar>
      <FormNew v-bind:sidebar-thanks="sidebarThanks" v-on:sidebar-update="sidebarThanks = $event"></FormNew>
    </div>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import SideBar from 'components/SideBar.vue';
import FormNew from 'components/FormNew.vue';

import 'flower.png'

export default {
  components: {
    Header,FormNew,SideBar
  },
  data: function () {
    return {
      sidebarThanks: {
        thanks: [],
        receivers: [],
        editUrls: []
      }
    }
  }
}
</script>

<style scoped>
#app {
  background-image: url('~flower.png');
  background-color:rgba(255,255,255,0.8);
  background-blend-mode:lighten;
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
