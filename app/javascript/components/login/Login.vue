<template>
  <div id="app">
    <Header></Header>
    <div class="main-box">
      <LoginContents></LoginContents>
    </div>
  </div>
</template>

<script>
import Header from '../shared/Header.vue';
import LoginContents from 'components/login/LoginContents.vue';
import 'flower.png'

export default {
  components: {
    Header, LoginContents
  },
  data: function () {
    return {
      message: "Hello Vue!"　
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
