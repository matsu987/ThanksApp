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
      <div v-for="(thank, index) in thanks" class="content" :key="thank.id" @click="editThank(index)" ref="user">
        <div v-if="thank.transmission_status == 0" class="content_name_unopened">編集中</div>
        <div v-else class="content_name_opened">確定</div>
        <div class="content_text">{{thank.text}}</div>
        <div class="content_from-user">
          <img v-if="thank.receiver.avatar.url" class="avatar-img" :src="thank.receiver.avatar.url">
          <img v-else class="avatar-img" src="~person.png">
          <div class="user-name">{{thank.receiver.name}}さん</div>
        </div>
      </div>
    </div>
    <!--  編集ポップアップ -->
    <div class="overlay" v-show="showContent">
      <form class="form">
        <h2 class="form__title">編集</h2>
        <div v-if= "thank.receiver.id" class="form__reciever">
          <img v-if="thank.receiver.avatar.url" class="form__reciever__img" :src="thank.receiver.avatar.url">
          <img v-else class="form__reciever__img" src="~person.png">
          <p class="form__reciever__name">To: {{thank.receiver.name}}さん</p>
        </div>
        <textarea class="form__text" v-model="thank.text" type="text" placeholder="感謝を具体的に書きましょう"></textarea>
        <div class="form__sender">
          <img v-if="thank.sender.avatar.url" class="form__avatar" :src="thank.sender.avatar.url">
          <img v-else class="form__avatar" src="~person.png">
          <p class="form__sender__name">From: {{ thank.sender.name }}</p>
        </div>
        <div class="form__btn-box">
          <div class="form__btn-box__second">
            <button class="form__btn-box__close">保存せずに閉じる</button>
            <button class="form__btn-box__delete" @click="deleteThank">削除</button>
          </div>
          <button class="form__btn-box__one-time" @click="oneTime">一時保存</button>
          <button class="form__btn-box__confirm" @click="confirm">確定</button>
        </div>
      </form>
    </div>

    <!-- 投稿完了ポップアップ-->
    <div class="popup">
      <div class="overlay-finish" v-show="showfinishContent">
        <div class="overlay-finish__content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li v-for="error in errors"><font color="red">{{ error }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">更新が完了しました！</p>
          <button class="overlay-finish__close-btn" v-on:click="closefinishModal">Close</button>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'person.png'

export default {

  data: function(){
    return {
      // ありレターの数はlength、senderとtextも入っている。
      thanks: [],
      send: {
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
      },
      showfinishContent: false,
      errors: ''
    }
  },
  created(){
    //年月の取得
    var now = new Date();
    this.$data.send.year = now.getFullYear()
    this.$data.send.month = now.getMonth() + 1
    // 受信したありレターの取得
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };

    let url = `/api/users/id/letters/send.json`;
    axios
    .get(url, {
      params: {
        send_year: this.$data.send.year,
        send_month: this.$data.send.month
      }
    })
    .then( response => {
      this.$data.thanks = response.data

    })
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
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
    },
    increClick: function(){
      if(this.send.month < 12 ){
        this.send.month++
        axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        };
        var url = location.pathname + ".json"
        axios
        .get(url, {
          params: {
            send_year: this.$data.send.year,
            send_month: this.$data.send.month
          }
        })
        .then( response => {
          this.$data.thanks = response.data.send_thanks
        })
      }else{
        this.send.year++
        this.send.month = 1
        axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        };
        var url = location.pathname + ".json"
        axios
        .get(url, {
          params: {
            send_year: this.$data.send.year,
            send_month: this.$data.send.month
          }
        })
        .then( response => {
          this.$data.thanks = response.data.send_thanks
        })
}
    },
    decreClick: function(){
      if(this.send.month > 1){
        this.send.month--
        axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        };
        var url = location.pathname + ".json"
        axios
        .get(url, {
          params: {
            send_year: this.$data.send.year,
            send_month: this.$data.send.month
          }
        })
        .then( response => {
          this.$data.thanks = response.data.send_thanks
        })
      }else{
        this.send.year--
        this.send.month = 12
        axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        };
        var url = location.pathname + ".json"
        axios
        .get(url, {
          params: {
            send_year: this.$data.send.year,
            send_month: this.$data.send.month
          }
        })
        .then( response => {
          this.$data.thanks = response.data.send_thanks
        })
      }
    },
    editThank: function(e){
      this.$data.thank = this.$data.thanks[e]
      this.openModal();
    },
    updateThank: function(e){
      e.preventDefault();
      let url = `/api/users/:user_id/letters/send/${this.thank.id}.json`
      axios
        .patch(url, this.thank)
        .then(response => {
          this.errors = '';
          if (response.status === 201){
            this.$data.showfinishContent = true
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            }
          } else if (response.status === 200){
            this.$data.showfinishContent = true
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            }
          }else {
            let e = response.data;
          }
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });

    },
    confirm: function(e){
      this.$data.thank.transmission_status = true
      this.updateThank(e);
    },
    oneTime: function(e){
      this.$data.thank.transmission_status = false
      this.updateThank(e);
    },
    deleteThank: function(e){
      e.preventDefault();
      let url = `/api/users/:user_id/letters/send/${this.thank.id}.json`
      axios
        .delete(url, this.thank)
        .then(response => {
          this.errors = '';
          if (response.status === 201){
            this.$data.showfinishContent = true
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
          }

          } else {

            let e = response.data;
          }
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    closefinishModal: function(e) {
      this.$data.showfinishContent = false
      document.location.reload();
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

/* 編集ポップアップ */
.overlay{
  width: 38%;
  height: 90%;
  z-index: 1;
  position: fixed;
  top: 4%;
  left: 48%;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
  box-sizing: border-box;
  display: flex;
  justify-content: center;
}

.form {
  width: 80%;
}

.form__title {
  margin: 20px 0;
  color: #ff0000;
  text-align: center;
}

.form__reciever {
  display: flex;
  margin: 10px 50px 10px 0;
}

.form__reciever__img {
  height: 50px;
  width: 50px;
  border-radius: 999px;
}

.form__reciever__name {
  line-height: 50px;
  margin-left: 10px;
}

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

.form__text {
  height: 60%;
  width: 100%;
  border: 1px solid #ff0000;
}

.form__sender {
  display: flex;
  justify-content: flex-end;
  margin: 10px 50px 10px 0;
}

.form__avatar {
  height: 50px;
  width: 50px;
  border-radius: 999px;
}

.form__sender__name {
  line-height: 50px;
  margin-left: 10px;
}

.form__btn-box {
  display: flex;
  justify-content: flex-end;
}

.form__btn-box__second {
  width: 35%;
}

.form__btn-box__close {
  display: block;
  border-radius: 18px;
  background: #fff;
  border: 2px solid #BDBDBD;
  width: 100%;
  height: 30px;
  color: #BDBDBD;
  margin-bottom: 10px;
}

.form__btn-box__delete {
  display: block;
  border-radius: 18px;
  background: #BDBDBD;
  width: 100%;
  height: 30px;
  color: #fff;
  border: none;
}

.form__btn-box__one-time {
  display: block;
  border-radius: 18px;
  border: 2px solid #ff0000;
  background: #fff;
  width: 35%;
  height: 70px;
  color: #ff0000;
  margin: 0 10px;
}

.form__btn-box__confirm {
  display: block;
  background: linear-gradient(160.47deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border-radius: 18px;
  border: none;
  width: 25%;
  height: 70px;
  color: white;
}

/* 更新完了ポップアップ */
.overlay-finish{
  width: 60%;
  height: 50%;
  z-index: 1;
  position: fixed;
  top: 25%;
  left: 20%;
  background-color: #fff;
  border-radius: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.error-message {
  display: block;
  margin-bottom: 40px;
  padding-top: 40px;
  font-size: 20px;
  text-align: center;
}

.success-message {
  display: block;
  margin-bottom: 40px;
  padding-top: 40px;
  font-size: 20px;
  color: #92CECA;
  text-align: center;
}

.sub-message {
  font-size: 14px;
  text-align: center;
}

.overlay-finish__close-btn {
  display: block;
  margin: auto;
  width: 200px;
  height: 50px;
  border-radius: 25px;
  border: none;
}
</style>
