<template>
  <div id="app" class="container">
    <Header :nav="mypageNav"></Header>
    <ReceiveContents></ReceiveContents>
  </div>
</template>

<script>
import axios from 'axios'
import Header from 'components/shared/Header.vue';
import ReceiveContents from 'components/letters/receive/ReceiveContents.vue';

export default {
  components: {
    Header, ReceiveContents
  },
  data: function () {
    return {
      mypageNav: "receive"
    }
  },
  created: function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };    

    axios
      .get('/thanks.json')
      .then(response => {
        this.$data.current_user = response.data.current_user
      });
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
