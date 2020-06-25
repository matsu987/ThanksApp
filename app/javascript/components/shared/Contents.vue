<template>
  <main>

  </main>
</template>

<script>
import axios from 'axios';
import SideBar from 'components/side_bar/SideBar.vue';

export default {
  components: { SideBar },
  data: function(){
    return {
      // myPageUrl: '/',
      // sideBar: false,
      // menu: true
    }
  },
  // created() {
  //   axios
  //   .get('/users.json')
  //   .then(response => {
  //     this.$data.myPageUrl = `/users/${response.data.current_user.id}`
  //   });
  // },
  methods: {
    openMenu: function(){
      this.sideBar = true
      this.menu = false
    },
    onCloseMenu: function(e){
      this.sideBar = false
      this.menu = true
    }
  }
}
</script>

<style scoped>

</style>
