<template>
  <a :href="path">
    <div class="index-content-box">
      <div class="thanks-content">
        <img :src="image" :alt="imageName">
        <center>{{ messageFirst }}</center>
        <center v-if="messageSecond">{{ messageSecond }}</center>
      </div>
    </div>
  </a>
  

</template>

<script>
import 'zibunno.png'
import 'send.png'
import 'minnano.png'

export default {
  props: [ 'messageFirst', 'messageSecond', 'image', 'imageName', 'path'],
  data: function(){
    return{
    }
  },
  methods: {
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
}
.thanks-content{
  margin-top: 40px;
  margin-right: 44px;
  width: 250px;
  height: 250px;
  letter-spacing: 0.05em;
}
.thanks-content.last{
  margin-right: 0;
}
.thanks-content img{
  width: 140px;
  height:140px;
}
.thanks-content:hover{
  border-radius: 50%;
  /* border: solid 3px #FFC967; */
  background: rgba(255, 201, 103, 0.7);
  backdrop-filter: blur(4px);
}
</style>
