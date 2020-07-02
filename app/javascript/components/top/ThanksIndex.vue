<template>
  <div id="app" class="container">
    <Header></Header>
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
    }
  },
  // created: function(){
  //   this.current_user = {}
  //   axios
  //     .get('/thanks.json')
  //     .then(response => {
  //       var user = response.data.current_user
  //     });
  //   console.log(user)
  // },
  // mounted(){
  //     axios.defaults.headers.common = {
  //       'X-Requested-With': 'XMLHttpRequest',
  //       'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  //     };
  //     axios
  //     .get('/thanks.json')
  //     .then( response => {
  //       console.log(this)
  //       this.$data.current_user = response.data.current_user
  //       console.log(this.$data.current_user)
  //     })
  // }
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
