<template>
  <div id="app" class="container">
    <SideBar></SideBar>
    <GroupContents></GroupContents>
  </div>
</template>

<script>
import axios from 'axios'
import SideBar from 'components/side_bar/SideBar.vue';
import GroupContents from './GroupContents.vue';

export default {
  components: {
    SideBar, GroupContents
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
</style>
