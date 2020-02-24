<template>
  <div id="app">
    <Header></Header>
    <a href="/users/1/mypages">test</a>
    <div class="main-box">
     <MypageIndexContents></MypageIndexContents>
    </div>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import MypageIndexContents from 'components/MypageIndexContents.vue';
import 'flower.png'

export default {
  components: {
    Header, MypageIndexContents
  },
  data: function () {
    return {
      current_user: {},

    }
  }
}
</script>

<style scoped>
#app {
  background-image: url('~flower.png');
  background-color:rgba(255,255,255,0.8);
  background-blend-mode:lighten;
}
.main-box {
  display: flex;
  height: calc( 100vh - 100px);
  width: 100%;
}
p {
  font-size: 2em;
  text-align: center;
}
</style>
