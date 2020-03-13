<template>
  <div id="app">
    <Header></Header>
    <MessagesBox></MessagesBox>
    </div>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import MessagesBox from 'components/MessagesBox.vue';
import 'flower.png'

export default {
  components: {
    Header,MessagesBox
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
