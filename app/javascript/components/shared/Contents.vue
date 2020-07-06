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
      groups: [],
      showContent: false
    }
  },
  created() {
  },
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
