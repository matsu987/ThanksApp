<template>
  <main>
    <div class="main-header">
      <div class="timebox">
        <span v-on:click="decreClick">←</span>
        <div class="time">
          {{send.year}}年{{send.month}}月
        </div>
        <span v-on:click="increClick">→</span>
      </div>
      <div class="countbox">
        <div class="send-count">
          <p class="countbox_title">今月送る数</p>
          <p class="countbox_num">{{thanks_send_count}}</p>
        </div>
        <div class="send-edit">
          <p class="countbox_title">編集中</p>
          <p class="countbox_num">{{thanks_edit_count}}</p>          
        </div>
        <div class="send-confirm">
          <p class="countbox_title">確定</p>
          <p class="countbox_num">{{thanks_confirm_count}}</p>          
        </div>        
      </div>        
    </div>
    <div class="contents">
      <div v-for="thank in thanks" class="content">
        <div v-if="thank.transmission_status == 0" class="content_name_unopened">編集中</div>
        <div v-else class="content_name_opened">確定</div>
        <div class="content_text">{{thank.text}}</div>
        <div class="content_from-user">
          <div class="avatar-img"></div>
          <div class="user-name">{{thank.sender.family_name}}{{thank.sender.given_name}}さん</div>
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
      // ありレターの数はlength、senderとtextも入っている。
      thanks: [
        {
          id: "",
          text:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          sender: {
            id: "",
            family_name: "熊谷",
            given_name: "真理子",
            avatar: "test.jpeg"
          },
          transmission_status: "0"
        },
        {
          id: "",
          text:"testtesttesttest",
          sender: {
            id: "",
            family_name: "熊谷",
            given_name: "隆太郎",
            avatar: "test.jpeg"
          },
          transmission_status: "1"
        },
        {
          id: "",
          text:"いつもありがとう",
          sender: {
            id: "",
            family_name: "奥脇",
            given_name: "真人",
            avatar: "test.jpeg"
          },
          transmission_status: "1"
        },
        {
          id: "",
          text:"testtesttesttest",
          sender: {
            id: "",
            family_name: "長松軒",
            given_name: "昇悟",
            avatar: "test.jpeg"
          },
          transmission_status: "1"
        }
      ],
      send: {
        year: "2020",
        month: "6"
      }
    }
  },
  computed: {
    thanks_edit_count: function(){
      var edit_count = 0
      var thanks = this.$data.thanks
      for (var i = 0; i < thanks.length; i++) {
        if(thanks[i].transmission_status == "0"){
          edit_count++
        }
        
      }
      return edit_count;
    },
    thanks_send_count: function(){
      var thanks_count = this.$data.thanks.length
      return thanks_count
    },
    thanks_confirm_count: function(){
      var confirm_count = 0
      var thanks = this.$data.thanks
      for (var i = 0; i < thanks.length; i++) {
        if(thanks[i].transmission_status == "1"){
          confirm_count++
        }
      }
      return confirm_count
    }    
  },
  methods: {
    increClick: function(){
      if(this.send.month < 12 ){
        return this.send.month++
      }else{
        this.send.year++
        return this.send.month = 1
      }
    },
    decreClick: function(){
      if(this.send.month > 1){
        return this.send.month--
      }else{
        this.send.year--
        return this.send.month = 12
      }
    }
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

.main-header{
  display: flex;
  background: linear-gradient(166.64deg, #F9516F 11.31%, #FF8F6B 87.66%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(255,255,255,0.0);
  color: #ff0000;
  width: 90%;
  margin: 0 auto;
}

.timebox{
  display: flex;
  font-size: 24px;
  margin: 2rem;
  padding: 10px;
}
.timebox span{
  background: black;
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(255,255,255,0.0);
  color: black;  
}

.time{
  margin: 0 5px;
}

.countbox {
  background: linear-gradient(166.64deg, #F9516F 11.31%, #FF8F6B 87.66%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(255,255,255,0.0);
  color: #ff0000;
  margin: 2rem;
  /* 受信一覧との差分 */
  /* display: flex; */
  font-size: 24px;
  border: 1px solid #ff0000;
}

.send-count{
  display: flex;
}

.send-edit{
  display: flex;
}

.send-confirm{
  display: flex;
}

.countbox_title{
  padding: 10px;
  width: 250px;
}

.countbox_num{
  border-left: 1px solid #ff0000;
  padding: 10px;
  width: 50px;
}

.contents{
  width: 100%;
  padding: 0 5%;
  display: grid;
  grid-template-columns: 30% 30% 30%;
  grid-template-rows: 300px 300px;
  gap: 10px;
}
.content{
  background: #FFFFFF;
  padding: 10px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}
.content_name_unopened{
  text-align: center;
  line-height: 35px;
  height: 35px;
  background: linear-gradient(166.64deg, #F9516F 11.31%, #FF8F6B 87.66%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(255,255,255,0.0);
  color: #ff0000;
  font-family: Roboto;
  font-style: normal;
  font-weight: bold;
  font-size: 18px;
  border: 2px solid  #ff0000;
}

.content_name_opened{
  text-align: center;
  line-height: 35px;
  height: 35px;
  background: linear-gradient(166.64deg, #F9516F 11.31%, #FF8F6B 87.66%);
  color: #fff;
  font-family: Roboto;
  font-style: normal;
  font-weight: bold;
  font-size: 18px;
}

.content_text{
  margin-top: 15px;
  height: 150px;
  word-wrap: break-word;
  color: #444444;
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 12px;
  line-height: 170%;
  letter-spacing: 0.05em;
}
.content_from-user{
  display: flex;
  height: 60px;
}

.user-name{
  font-family: Roboto;
  font-style: normal;
  font-weight: bold;
  font-size: 18px;
  line-height: 55px;
  color: #444444;
  word-break: break-all;
}
.avatar-img {
  height: 55px;
  width: 55px;
  margin: auto;
  background: blue;
  border-radius: 999px;
}

</style>
