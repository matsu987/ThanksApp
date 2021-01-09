<template>
  <div id="app" class="container">
    <SideBar></SideBar>
    <OtherUserContents></OtherUserContents>
  </div>
</template>

<script>
import axios from 'axios'
import SideBar from 'components/side_bar/SideBar.vue';
import OtherUserContents from './OtherUserContents.vue';

export default {
  components: {
    SideBar, OtherUserContents
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

/* main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
} */
</style>
