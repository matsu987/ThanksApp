<template>
  <div id="app" class="container">
    <Header></Header>
    <GroupNewContent></GroupNewContent>
  </div>
</template>

<script>
import axios from 'axios'
import Header from '../shared/Header.vue';
import GroupNewContent from './GroupNewContent.vue';

export default {
  components: {
    Header, GroupNewContent
  },
  data: function () {
    return {
    }
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
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
/* nav{
  width: 20%;
  height: 100vh;
  background-color: #EDEDED;
} */
</style>
