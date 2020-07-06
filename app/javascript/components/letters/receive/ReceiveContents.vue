<template>
  <main>
    <div class="main-header">
      <div class="timebox">
        <span v-on:click="decreClick">←</span>
        <div class="time">
          {{receive.year}}年{{receive.month}}月
        </div>
        <span v-on:click="increClick">→</span>
      </div>
      <div class="countbox">
        <p class="countbox_title">今月受け取った数</p>
        <p class="countbox_num">{{thanks.length}}</p>
      </div>        
    </div>
    <div class="contents">
      <div v-for="thank in thanks" class="content">
        <div v-if="thank.reception_status == 0" class="content_name_unopened">未開封</div>
        <div v-else class="content_name_opened">開封済</div>
        <div class="content_text">{{thank.text}}</div>
        <div class="content_from-user">
          <img v-if="thank.sender.avatar.url" class="avatar-img" :src="thank.sender.avatar.url">
          <img v-else class="avatar-img" src="~person.png">
          <div class="user-name">{{thank.sender.name}}さん</div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'person.png';

export default {

  data: function(){
    return {
      // ありレターの数はlength、senderとtextも入っている。
      thanks: [
],
      receive: {
        year: "",
        month: ""
      }
    }
  },
  methods: {
    increClick: function(){
      // 12月じゃなかったらそのまま月を変更。変更した月で受信したありレターを取得する。
      if(this.receive.month < 12 ){
        this.receive.month++
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = location.pathname + ".json"
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month 
            }
          })
          .then( response => {
            this.$data.thanks = response.data.receive_thanks
          })
      }else{
      // 12月じゃなかったらそのまま月を変更。変更した月で受信したありレターを取得する。
        this.receive.year++
        this.receive.month = 1
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = location.pathname + ".json"
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month
            }
          })
          .then( response => {
            this.$data.thanks = response.data.receive_thanks
          })
      }
    },
    decreClick: function(){
      if(this.receive.month > 1){
        this.receive.month--
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = location.pathname + ".json"
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month
            }
          })
          .then( response => {
            this.$data.thanks = response.data.receive_thanks
          })
      }else{
        this.receive.year--
        this.receive.month = 12
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = location.pathname + ".json"
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month
            }
          })
          .then( response => {
            this.$data.thanks = response.data.receive_thanks
          })
      }
    }
  },
  created(){
    // 年月の取得
    var now = new Date();
    this.$data.receive.year = now.getFullYear()
    this.$data.receive.month = now.getMonth() + 1
    // 受信したありレターの取得
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
    var url = location.pathname + ".json"
    axios
    .get(url, {
      params: {
        receive_year: this.$data.receive.year,
        receive_month: this.$data.receive.month
      }
    })
    .then( response => {
      this.$data.thanks = response.data.receive_thanks
    })
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
  display: flex;
  font-size: 24px;
  border: 1px solid #ff0000;
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
  overflow: hidden;
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
  border-radius: 999px;
}

</style>
