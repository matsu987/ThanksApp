<template>
  <div id="app" class="container">
    <Header header-nav="Mypage" mypage-nav="group"></Header>
    <AdminUsersContents></AdminUsersContents>
  </div>
</template>

<script>
import axios from 'axios'
import Header from '../../shared/Header.vue';
import AdminUsersContents from './AdminUsersContents.vue';

export default {
  components: {
    Header, AdminUsersContents
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

main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
  margin-left: 35%;
}
</style>
