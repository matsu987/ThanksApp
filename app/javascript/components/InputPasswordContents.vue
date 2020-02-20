<template>
  <center class="thanks-index">
    <div class="thanks-index-message">
      <div class="index-message-image">
        <img src="~Surprisethanks.png" alt="Suprisethanks.png">
      </div>
    </div>
    <div class="index-contents">

    </div>
  </center>
</template>

<script>
import 'zibunno.png'
import 'send.png'
import 'minnano.png'
import 'Surprisethanks.png'

export default {
  data: function(){
    return {
    }
  },
  components: {  },
  methods: {
  }
}
</script>

<style scoped>
  .thanks-index{
    width: 80%;
    margin: 0 auto;
    font-size: 14px;
    font-family: Noto Sans CJK JP;
  }
  .index-message-middle {
    margin-top: 20px;
  }
  .index-message-middle h2{
    font-size: 36px;
    letter-spacing: 0.2em;
    margin-bottom: 20px;
}
  .middle-article{
    letter-spacing: 0.15em;
  }
  .index-contents{
    display: flex;
    
  }
  .index-content{
    width: 33%;
  }

</style>
