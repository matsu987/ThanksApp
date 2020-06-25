<template>
  <div id="app">
    <Header></Header>
    <ReceptionBox></ReceptionBox>
  </div>
</template>

<script>
import Header from 'components/shared/Header.vue';
import ReceptionBox from 'components/ReceptionBox.vue';
import 'flower.png'

export default {
  components: {
    Header,ReceptionBox
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
p {
  font-size: 2em;
  text-align: center;
}
</style>
