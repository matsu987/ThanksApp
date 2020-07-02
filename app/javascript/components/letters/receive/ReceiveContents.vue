<template>
  <main>
    <div class="main-header">
      <div class="timebox">
        <i></i>
        <div class="time">
          6月
        </div>
        <i></i>
      </div>
      <div class="countbox">
        <p>今月受け取った数</p>
        <p>8</p>
      </div>
    </div>
    <div class="contents">
      <div class="content">
        <div class="content_name">未開封</div>
        <div class="content_text">xxxxxxxxxxxxxxxxxxxxxxxxxxxxx</div>
        <div class="content_from-user">
          <div class="avatar-img"></div>
          <div class="user-name">xxxxxxxxさん</div>
        </div>
      </div>
      <div class="content">
        <div class="content_name">未開封</div>
        <div class="content_text">xxxxxxxxxxxxxxxxxxxxxxxxxxxxx</div>
        <div class="content_from-user">
          <div class="avatar-img"></div>
          <div class="user-name">xxxxxxxxさん</div>
        </div>
      </div>
      <div class="content">
        <div class="content_name">未開封</div>
        <div class="content_text">xxxxxxxxxxxxxxxxxxxxxxxxxxxxx</div>
        <div class="content_from-user">
          <div class="avatar-img"></div>
          <div class="user-name">xxxxxxxxさん</div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';

export default {

  data: function(){
    return {
      thanks: [],
      // ありレターの数はlength、senderとtextも入っている。
      //thanks [{
      // id: "",
      // text:"",
      // sender: {
      //   id: "",
      //   family_name: "",
      //   given_name: "",
      //   avatar: ""
      // },{}]
      receive: {
        year: "",
        month: ""
      }
    }
  },

  created() {
    var url = location.pathname + ".json"
    axios
      .get(url)
      .then(response => {
        var thanks = response.data.receive_thanks
        this.$data.thanks = thanks
        this.$data.senders = response.data.senders
      });
  }
}
</script>

<style scoped>
main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
  margin-left: 35%;
}

.avatar-img {
  height: 40px;
  width: 40px;
  margin-left: 200px;
  border-radius: 999px;
}
</style>
