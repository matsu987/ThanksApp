<template>
  <main>
    <section class="user-avatar__form">
      <h2>基本情報</h2>
      <form class="user-form" @submit.prevent="updateUser">
        <div class="user-edit__box">
          <div class="user-edit__form">
            <label for="avatar" class="avatar-label">
              <p>プロフィール画像</p>
              <img v-if="confirmedImage" class="avatar-img" :src="confirmedImage">
              <img v-else-if="avatar" class="avatar-img" :src="avatar">
              <img v-else class="avatar-img" src="~avatar.png">
            </label>
            <input type="file" class="hidden" id="avatar" accept="image/jpeg, image/png" @change="confirmImage"/>
          </div>
          <div class="user-edit__form">
          　<label>姓</label>
            <input type="text" class="user-edit__form__avatar-text" v-model="current_user.family_name" :placeholder="current_user.family_name">
          </div>
          <div class="user-edit__form">
            <label>名</label>
            <input type="text" class="user-edit__form__avatar-text" v-model="current_user.given_name" :placeholder="current_user.given_name">
          </div>
        </div>
        <input type="submit" value="変更" class="user-edit__form__submit" >
      </form>
    </section>

    <section>
      <h2>所属情報</h2>
      <form class="group-edit user-form">
        <div class="group-edit__box">
          <div class="user-edit__form">
            <label>会社登録</label>
            <select class="user-edit__form__group-text">
              <option value="">選択してください</option>
            </select>
          </div>
          <div class="user-edit__form">
            <label>部署登録</label>
            <select class="user-edit__form__group-text">
              <option value="">選択してください</option>
            </select>
          </div>
        </div>
        <input type="submit" value="変更" class="group-edit__form__submit">
      </form>
    </section>

    <section>
      <h2>ログイン情報</h2>
      <form class="user-form" @submit.prevent="updateLogin">
        <div class="login-edit__box">
          <div class="user-edit__form">
            <label>メールアドレス</label>
            <input type="email" class="user-edit__form__login-text" v-model="current_user.email" :placeholder="current_user.email">
          </div>
          <div class="user-edit__form">
            <label>パスワード</label>
            <input type="password" class="user-edit__form__login-text login-text__password" autocomplete="new-password" v-model="current_user.password">
          </div>
        </div>
        <input type="submit" value="変更" class="login-edit__form__submit">
      </form>
    </section>
  </main>
</template>

<script>
import axios from 'axios';
import 'avatar.png';

export default {
  data: function () {
    return {
      current_user: {
        password: "",
      },
      avatar: '',
      file: "",
      confirmedImage: ""
    }
  },
  created() {
    axios
    .get('/users.json')
    .then(response => {
      this.$data.current_user = response.data.current_user
      this.$data.avatar = response.data.avatar
    });
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  },
  methods: {
    updateUser: function(event) {
      let url = "/users/" + this.current_user.id
      let data = new FormData();
      data.append("avatar", this.file);
      data.append("family_name", this.current_user.family_name);
      data.append("given_name", this.current_user.given_name);

      axios
        .patch(url, data)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
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
    updateLogin: function(event) {
      let url = "/users/" + this.current_user.id + "/login_update"
      axios
        .patch(url, {email: this.current_user.email, password: this.current_user.password})
        .then(response => {
          this.errors = '';
          if (response.status === 200){
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
    confirmImage(e) {
      this.message = "";
      this.file = e.target.files[0];
      if (!this.file.type.match("image.*")) {
          this.message = "画像ファイルを選択して下さい";
          this.confirmedImage = "";
          return;
      }
      this.createImage(this.file);
    },
    createImage(file) {
      let reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = e => {
        this.confirmedImage = e.target.result;
      };
    },
  },
}
</script>

<style scoped>
* {
  font-size: 14px;
}

h2 {
  font-size: 16px;
  padding-left: 20px;
  border-bottom: inset 2px #ff0000;
}

section {
  width: 80%;
  height: 200px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  padding: 10px 30px;
  margin: 35px auto;
}

form {
  padding: 20px;
}

.user-form {
  display: flex;
  padding-top: 40px;
}

.user-edit__form {
  display: flex;
  padding-bottom: 20px;
}

input[type="submit"] {
  width: 100px;
  height: 35px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
}

.hidden {
  display: none;
}

/*　ユーザー編集 */
.user-avatar__form {
  height: 250px;
}

.user-edit__box {
  width: 83%;
}

.avatar-label {
  display: flex;
}

.avatar-label p {
  line-height: 40px;
}

.avatar-img {
  height: 40px;
  width: 40px;
  margin-left: 200px;
  border-radius: 999px;
}

.user-edit__form__avatar-text {
  margin: 0 60px 0 135px;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.user-edit__form__submit {
  height: 80px !important;
  margin-top: 30px;
}

/* グループ編集 */

.group-edit__box {
  width: 83%;
}

.user-edit__form__group-text {
  margin: 0 20px 0 94px;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.group-edit__form__submit {
  height: 80px !important;
}
/* ログイン編集 */

.login-edit__box {
  width: 83%;
}

.user-edit__form__login-text {
  margin: 0 60px 0 50px;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.login-text__password {
  margin-left: 77px;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.login-edit__form__submit {
  height: 80px !important;
}
</style>
