<template>
  <center class="thanks-index">
    <div class="thanks-index-message">
      <div class="index-message-image">
        <img src="~Surprisethanks.png" alt="Suprisethanks.png">
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
      <ThanksContent class="index-content" path="" message-first="全サプライズサンクス一覧" image="/minnano.png" alt="minnano.png" image-name="ハガキ"></ThanksContent>
      <ThanksContent class="index-content" path="/thanks/new" message-first="新規作成" image="/send.png" image-name="メモ帳"></ThanksContent>
      <ThanksContent class="index-content" :path="receptionLink" message-first="受信一覧" message-second="" image="/zibunno.png" image-name="手紙"></ThanksContent> 
      <ThanksContent class="index-content last" :path="transmissionLink" message-first="送信一覧" message-second="" image="/transmission.png" image-name="送信一覧"></ThanksContent> 
    </div>
  </center>
</template>

<script>
import axios from 'axios';
import 'zibunno.png'
import 'send.png'
import 'minnano.png'
import 'transmission.png'
import 'Surprisethanks.png'
import ThanksContent from 'components/ThanksContent.vue';

export default {
  data: function(){
    return {
      transmissionLink: "",
      receptionLink: ""
    }
  },
  created() {
    axios
    .get('/thanks.json')
    .then(response => {
      this.$data.transmissionLink = `/users/${response.data.current_user.id}/transmissions`
      this.$data.receptionLink = `/users/${response.data.current_user.id}/receptions`
    });
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
    color: #333333;
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
