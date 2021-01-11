<template>
  <main>
    <div class="main-header">
      <div class="timebox">
        <span v-on:click="decreClick"><</span>
        <div class="time">
          {{receive.year}}年{{receive.month}}月
        </div>
        <span v-on:click="increClick">></span>
      </div>
      <div class="countbox">
        <div class="countbox-inner">
          <p class="countbox_title">今月受け取った数</p>
          <p class="countbox_num">{{thanks.length}}</p>
        </div>
      </div>        
    </div>
    <div class="contents">
      <div v-for="(thank, index) in thanks" class="content" @click="showThank(index)">
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

    <div class="overlay" v-show="showContent">
      <form class="form">
        <h2 class="form__title">詳細</h2>
        <div v-if= "thank.receiver.id" class="form__reciever">
          <img v-if="thank.receiver.avatar.url" class="form__reciever__img" :src="thank.receiver.avatar.url">
          <img v-else class="form__reciever__img" src="~person.png">
          <p class="form__reciever__name">To: {{thank.receiver.name}}さん</p>
        </div>
        <p class="form__text">{{thank.text}}</p>
        <div class="form__sender">
          <img v-if="thank.sender.avatar.url" class="form__avatar" :src="thank.sender.avatar.url">
          <img v-else class="form__avatar" src="~person.png">
          <p class="form__sender__name">From: {{ thank.sender.name }}</p>
        </div>
        <button class="btn btn-color-close btn-size-md btn-type-round" @click="closeModal">閉じる</button>
      </form>
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
      thanks: [],
      receive: {
        year: "",
        month: ""
      },
      showContent: false,
      thank: {
        id: '',
        text: '',
        transmission_status: false,
        reception_status: false,
        receiver: {
          id: '',
          name: '',
          avatar: ''
        },
        sender: {
          id: '',
          name: '',
          avatar: ''
        }
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
    var url = `/api/users/id/letters/receive.json`
    axios
    .get(url, {
      params: {
        receive_year: this.$data.receive.year,
        receive_month: this.$data.receive.month
      }
    })
    .then( response => {
      this.$data.thanks = response.data
    })
  },
  methods: {
    openModal: function(e){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
    },
    increClick: function(){
      // 12月じゃなかったらそのまま月を変更。変更した月で受信したありレターを取得する。
      if(this.receive.month < 12 ){
        this.receive.month++
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = '/api/users/id/letters/receive.json'
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month 
            }
          })
          .then( response => {
            this.$data.thanks = response.data
          })
      }else{
      // 12月じゃなかったらそのまま月を変更。変更した月で受信したありレターを取得する。
        this.receive.year++
        this.receive.month = 1
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = '/api/users/id/letters/receive.json'
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month
            }
          })
          .then( response => {
            this.$data.thanks = response.data
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
          var url = `/api/users/id/letters/receive.json`
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month
            }
          })
          .then( response => {
            this.$data.thanks = response.data
          })
      }else{
        this.receive.year--
        this.receive.month = 12
          axios.defaults.headers.common = {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          };
          var url = '/api/users/id/letters/receive.json'
          axios
          .get(url, {
            params: {
              receive_year: this.$data.receive.year,
              receive_month: this.$data.receive.month
            }
          })
          .then( response => {
            this.$data.thanks = response.data
          })
      }
    },
    showThank: function(e){
      this.$data.thank = this.$data.thanks[e]
      this.openModal();
    }
  }
}
</script>

<style scoped>
/* main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
  margin-left: 300px;
} */

/* .main-header{
  display: flex;
  background: linear-gradient(166.64deg, #F9516F 11.31%, #FF8F6B 87.66%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(255,255,255,0.0);
  color: #ff0000;
  width: 90%;
  margin: 0 auto;
} */

/* .timebox{
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
} */

/* .countbox {
  background: linear-gradient(166.64deg, #F9516F 11.31%, #FF8F6B 87.66%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: rgba(255,255,255,0.0);
  color: #ff0000;
  margin: 2rem;
  display: flex;
  font-size: 24px;
  border: 1px solid #ff0000;
} */

/* .countbox_title{
  padding: 10px;
  width: 250px;
} */

/* .countbox_num{
  border-left: 1px solid #ff0000;
  padding: 10px;
  width: 50px; */
/* } */

/* .contents{
  width: 100%;
  padding: 0 5%;
  display: grid;
  grid-template-columns: 30% 30% 30%;
  grid-template-rows: 300px 300px;
  gap: 10px;
} */
/* .content{
  background: #FFFFFF;
  padding: 10px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
} */
/* .content_name_unopened{
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
} */

/* .user-name{
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
} */

/* 詳細ポップアップ */
/* .overlay{
  width: 50%;
  height: 85%;
  z-index: 1;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
  box-sizing: border-box;
  display: flex;
  justify-content: center;
  border-radius: 8px;
  padding: 40px 24px;
} */

/* .form__reciever__img {
  height: 50px;
  width: 50px;
  border-radius: 999px;
} */

/* .form__reciever__name {
  line-height: 50px;
  margin-left: 10px;
} */

.form__user-btn {
  display: block;
  background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border-radius: 18px;
  border: none;
  width: 30%;
  height: 45px;
  color: white;
  margin: 20px 0 20px 0;
}

/* .form__text {
  height: 60%;
  width: 100%;
  border: 1px solid #ff0000;
  word-break: break-all;
  padding: 16px;
  font-size: 14px;
  line-height: 1.8;
  letter-spacing: .08em;
  margin: 16px auto;
} */

.form__sender {
  display: flex;
  justify-content: flex-end;
  /* margin: 10px 50px 10px 0; */
}

.form__avatar {
  height: 50px;
  width: 50px;
  border-radius: 999px;
}

/* .form__sender__name {
  line-height: 50px;
  margin-left: 10px;
} */

.form__btn-box {
  /* display: flex;
  justify-content: flex-end; */
}

.form__btn-box__second {
  width: 35%;
}

/* .form__btn-box__close {
  display: block;
  border-radius: 18px;
  background: #fff;
  border: 2px solid #BDBDBD;
  width: 100%;
  height: 30px;
  color: #BDBDBD;
  margin-bottom: 10px;
} */

</style>
