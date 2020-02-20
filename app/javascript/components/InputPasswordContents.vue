<template>
  <center class="thanks-index">
    <div class="thanks-index-message">
      <div class="index-message-image">
        <img src="~Surprisethanks.png" alt="Suprisethanks.png">
      </div>
    </div>
    <div class="index-contents">
      <PasswordForm></PasswordForm>
    </div>
  </center>
</template>

<script>
import 'zibunno.png'
import 'send.png'
import 'minnano.png'
import 'Surprisethanks.png'
import PasswordForm from 'components/PasswordForm.vue';

export default {
  data: function(){
    return {
    }
  },
  components: { PasswordForm },
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
    justify-content: center;
    
  }
  .index-content{
    width: 33%;
  }

</style>
