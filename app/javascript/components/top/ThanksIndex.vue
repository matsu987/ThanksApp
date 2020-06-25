<template>
  <div id="app" class="container">
    <Header v-on:change="onchange" :currentTab="currentHeaderTab"></Header>
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
      currentHeaderTab: "mypage"
    }
  },
  methods: {
    onchange: function(e){
      this.currentHeaderTab = e;

    }
  },
  // 後に追加予定
  // ログイン中のユーザーを取得してHeader、Navに渡す。
  // created() {
  //   axios
  //   .get(url)
  //   .then(response => {
  //     console.log(response)
  //     this.$data.current_user = response.data.current_user
  //     this.$data.company      = response.data.company
  //   });
  // },
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
main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
}
</style>
