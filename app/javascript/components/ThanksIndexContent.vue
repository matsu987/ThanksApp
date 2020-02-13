<template>
  <center class="thanks-index">
    <div class="thanks-index-message">
      <div class="index-message-image">
        <img src="/assets/Surprisethanks.png" alt="Suprisethanks.png">
      </div>
      <section class="index-message-middle">
        <h2>"感謝を伝える"</h2>
        <div class="middle-article">
          <center>人はどんな恵まれた状況にも慣れてしまう。</center>
          <center>日頃から心からの感謝を伝えることで幸せを再認識できる。</center>
          <center>出会うすべての人に「ありがとう」を伝える。</center>
        </div>
      </section>
    </div>
    <div class="index-contents">
      <ThanksContent class="index-content" path="" message-first="みんなの" message-second="サプライズサンクスを見る" image="/assets/send.png" image-name="ハガキ"></ThanksContent>
      <ThanksContent class="index-content" path="/thanks/new" message-first="サプライズサンクスを送る" image="/assets/send.png" image-name="メモ帳"></ThanksContent>
      <ThanksContent class="index-content last" path="" message-first="自分に届いた" message-second="サプライズサンクスを見る" image="/assets/zibunno.png" image-name="手紙"></ThanksContent> 
    </div>
  </center>
</template>
　　　　　　　　
<script>
// suprise_thanks用のpngもらう
import 'zibunno.png'
import 'send.png'
import 'minnano.png'
import 'Surprisethanks.png'
import ThanksContent from 'components/ThanksContent.vue';

export default {
  data: function(){
    return {
    }
  },
  components: { ThanksContent },
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
