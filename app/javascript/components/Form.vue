<template>
  <div>
    <div class="overlay" v-show="showContent">
      <div class="content">
        <div v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li><font color="red">{{ e }}</font></li>
          </ul>
        </div>
        <p v-if="errors.length == 0">投稿完了しました！</p>
        <button v-on:click="closeModal">Close</button>
      </div>
    </div>
    <form class="thanks-form" @submit.prevent="createThank">
      <div class="receiver-select">
        <label>サプライズのある仕事をした人</label>
        <input v-model="thank.receiver_id" type="text">
      </div>
      <div class="thanks-message">
        <label>熱い感謝のメッセージ</label>
        <textarea v-model="thank.text" type="text"></textarea>
      </div>
      <button class="thanks-btn" type="submit">送信</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      thank: {
        sender_id: '',
        text: ''
      },
      errors: '',
      showContent: false
    }
  },
  mounted:function(){
    axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')};

  },
  methods: {
    openModal: function(){
      this.showContent = true
    },
    closeModal: function(){
      this.showContent = false
    },
    resetForm: function(){
      this.$data.thank.receiver_id = ''
      this.$data.thank.text = ''
    },
    createThank: function(event) {
      axios
        .post('/thanks', this.thank)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
          }

          } else {

            let e = response.data;
          }
          this.openModal();
          this.resetForm();
        })
        // .catch(error => {
        //   console.error(error.response.data.errors);
        //   if (error.response.data && error.response.data.errors) {
        //     this.errors = error.response.data.errors;
        //   }
    }
  }
}
</script>

<style scoped>
.thanks-form {
  border: solid;
}

.receiver-select {
  margin: 50px 50px;
}

.thanks-message {
  margin: 50px 50px;
}

.thanks-btn {
  margin: 0 250px;
}

.content{
  z-index:10;
  width:50%;
  padding: 1em;
  background:#fff;
}

.overlay{
  /*　要素を重ねた時の順番　*/

  z-index:1;

  /*　画面全体を覆う設定　*/
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-color:rgba(0,0,0,0.5);

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;

}

p {
  font-size: 2em;
  text-align: center;
}
</style>
</style>
