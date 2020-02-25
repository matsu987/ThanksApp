<template>
  <div class="password_contents">
    <div class="overlay" v-show="showContent">
      <div class="content">
        <div class="error-message" v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li><font color="red">{{ e }}</font></li>
          </ul>
        </div>
        <p class="success-message" v-if="errors.length == 0">パスワード入力確認いたしました！<br><span class="sub-message">早速感謝の言葉をお伝えしましょう^^</span></p>
        <button class="close-btn" v-on:click="closeModal">Close</button>
      </div>
    </div>
    <form action="/users/confirmation" accept-charset="UTF-8" method="post">
      <div class="form_content">
        <div class="password_form">
          <label for="pass">PASS</label>
          <input autocomplete="off" type="password" name="user[password]" id="pass" />
        </div>
      </div>
      <div class="form_bottom_content">
        <input type="submit" name="commit" value="パスワードを確定する">
          <p>
            <a href="#" class="resetting_pass">
              パスワードを再設定する ▶ ︎
            </a>
          </p>
      </div>
    </form>
  </div>
</template>

<script>

export default {
  data: function(){
    return{
      errors: '',
    }
  },
  methods: {
    userSelect: function(e){
      e.preventDefault();
    },
    onInput: function(){
      axios
        .get('/search/users/index.json', {params: this.keyword})
        .then(response => {
          this.$data.searchUsers = []
          console.log(response)
          if (response.data.length !== 0){
            var users = response.data
            var array = this.$data.searchUsers

            users.forEach(user => {
              array.push(user);
            });
          }
        })
    },
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
    },
    resetForm: function(){
      this.$data.keyword = ''
      this.$data.thank.text = ''
    },
    createThank: function(event) {
      var users = this.$data.searchUsers

      users.forEach(user => {
        if (user.name === this.keyword){
          this.$data.thank.receiver_id = `${user.id}`;
        }
      });

      axios
        .post('/thanks.json', this.thank)
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
          this.$data.searchUsers = []
        })
        .catch(error => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateThank: function(event) {
      axios
        .post('/thanks.json', this.thank)
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
        .catch(error => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  }
}
</script>

<style scoped>
  .password_contents{
    background-color: #FAFAFA;
    width: 800px;
    height: 400px;
    box-sizing: border-box;
  }
  .form_content{
    margin: 90px 0 40px; 
  }
  .form_content label{
    display: inline-block;
    background-color: #888888;
    width: 100px;
    line-height: 50px;
    color: #FFFFFF;
    font-family: Noto Sans CJK JP;
    font-size: 14px;
    letter-spacing: 0.02em;
    padding-right: 9px;
  }
  .form_content input{
    display: inline-block;
    width: 250px;
    height: 50px;
    background-color: #FFFFFF;
    box-sizing: border-box;
  }
  .form_content .password_form{
    padding-top: 33px;
  }
  .form_bottom_content input{
    width: 200px;
    height: 40px;
    color: #FFFFFF;
    border-radius: 40px;
    background-color: #FFC152;
    filter: drop-shadow(5px 5px 5px rgba(0, 0, 0, 0.25));
  }
  .form_bottom_content .resetting_pass{
    display: inline-block;
    padding-top: 20px;
    color: #888888;
    font-family: Noto Sans CJK JP;
    letter-spacing: 0.02em;
  }
  .overlay{
  width: 50%;
  height: 50%;
  z-index: 1;
  position: fixed;
  top: 25%;
  left: 25%;
  background-color: #fff;
  border: 2px solid #555555;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: center;
  }

  .close-btn {
    display: block;
    margin: auto;

  }

  .success-message {
    display: block;
    margin-bottom: 40px;
    padding-top: 40px;
    font-size: 20px;
    color: #ADDCD9;
    text-align: center;
  }

  .sub-message {
      font-size: 14px;
      text-align: center;
  }

  .error-message {
    display: block;
    margin-bottom: 40px;
    padding-top: 40px;
    font-size: 20px;
    text-align: center;
  }
</style>
