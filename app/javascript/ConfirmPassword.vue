<template>
  <div id="app">
    <Header></Header>
    <div class="main-box">
      <ConfirmPasswordContents></ConfirmPasswordContents>
    </div>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import ConfirmPasswordContents from 'components/ConfirmPasswordContents.vue';
import 'flower.png'

export default {
  components: {
    Header, ConfirmPasswordContents
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
