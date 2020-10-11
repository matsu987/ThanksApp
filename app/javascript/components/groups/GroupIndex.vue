<template>
  <div class="container">
    <SideBar></SideBar>
    <GroupContents></GroupContents>
    <GroupModal></GroupModal>
  </div>
</template>

<script>
import axios from 'axios'
import GroupModal from './GroupModal.vue';
import SideBar from 'components/side_bar/SideBar.vue';
import GroupContents from './GroupContents.vue';

export default {
  components: {
    SideBar, GroupContents, GroupModal
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
