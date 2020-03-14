<template>
  <div id="app">
    <Header></Header>
    <div class="main-box">
      <ResetPasswordContents></ResetPasswordContents>
    </div>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import ResetPasswordContents from 'components/reset_password/ResetPasswordContents.vue';
import 'flower.png'

export default {
  components: {
    Header, ResetPasswordContents
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
