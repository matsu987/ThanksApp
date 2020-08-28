<template>
  <main>

    <!-- ポップアップ -->
    <div class="popup">
      <div class="overlay" v-show="showContent">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li><font color="red">{{ errors }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">登録が完了しました！<br><span class="sub-message">ユーザー設定画面から部署に参加してください</span></p>
          <button class="close-btn" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </div>

    <div v-if='current_company.name != ""'>
      <section class="company">
        <h2>会社情報</h2>
        <form class="company__form" @submit.prevent="updateCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="company__form__boxies__box form--required">会社名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">公開日時</p>
              </label>
              <input type="datetime" class="company__form__boxies__box__text" v-model="current_company.release_time" placeholder="例）2020年01月01日23:00">
            </div>
          </div>
          <div class="company__form__btn-box">
            <input v-if="current_company.admin" type="submit" value="編集" class="company__form__submit" >
            <button v-if="current_company.admin"  type="button" @click="releaseThanks" class="company__form__submit" >メッセージ<br>公開</button>
          </div>
        </form>
      </section>
    </div>
    <div v-else>
      <section class="company">
        <h2>会社登録</h2>
        <form class="company__form" @submit.prevent="createCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="form--required">会社名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="form--optional">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="form--optional">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="form--optional">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">公開日時</p>
              </label>
              <input type="datetime" class="company__form__boxies__box__text" v-model="current_company.release_time" placeholder="例）2020年01月01日23:00">
            </div>
          </div>
          <input type="submit" value="登録" class="company__form__submit" >
        </form>
      </section>
    </div>

    <div v-if="current_company.admin">
      <section class="group">
        <h2 class="group--admin">新部署登録</h2>
        <form class="group__form" @submit.prevent="createGroup">
          <div class="group__form__boxies">
            <div class="group__form__boxies__box">
              <label>会社登録</label>
              <select class="group__form__boxies__box__text">
                <option v-model="admin_group.name" :value="admin_group.id">{{admin_group.name}}</option>
              </select>
            </div>
            <div class="group__form__boxies__box" v-show="parent_group.show">
              <label>
                <div class="form--required">部署登録</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="parent_group.name" placeholder="親部署名" @input="onInputParent">
            </div>

            <div class="group__form__boxies__box" v-show="child_group.show">
              <label>
                <div class="form--optional">部署登録</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="child_group.name" placeholder="子部署名" @input="onInputChild">
            </div>

            <div class="group__form__boxies__box"v-show="grandchild_group.show">
              <label>
                <div class="form--optional">部署登録</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="grandchild_group.name" placeholder="孫部署名">
            </div>
          </div>
          <input type="submit" value="登録" class="group__form__submit">
        </form>
      </section>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'avatar.png';

export default {
  data: function () {
    return {
      company: {
        id: '',
        name: '',
        post_number: '',
        address: '',
        phone_number: '',
        release_time: ''
      },
      current_company: {
        id: '',
        name: '',
        post_number: '',
        address: '',
        phone_number: '',
        release_time: '',
        admin: false
      },
      admin_group: {},
      parent_group: {
        show: true,
        name: ''
      },
      child_group: {
        show: false,
        name: ''
      },
      grandchild_group: {
        show: false,
        name: ''
      },
      showContent: false,
      errors: '',
    }
  },
  created() {
    axios
    .get('/companies.json')
    .then(response => {
      if (Object.keys(response.data).length != 0){
        this.$data.current_company = response.data.company
        this.$data.current_company.admin = response.data.admin
      }
    });

    axios
    .get('/groups.json')
    .then(response => {
      this.$data.admin_group = response.data
    });
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  },
  methods: {
    openModal: function(){
      this.$data.showContent = true
    },
    closeModal: function(){
      this.$data.showContent = false
      document.location.reload()
    },
    createCompany: function(event) {
      axios
        .post("/companies", this.company)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            } else {
              this.openModal();
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
    updateCompany: function(event) {
      let url = "/companies/" + this.current_company.id + ".json"
      axios
        .patch(url, this.current_company)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
          } else {
            this.openModal();
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
    onInputParent: function(event) {
      if (this.parent_group.name == ""){
        this.child_group.show = false
      } else {
        this.child_group.show = true
      }
    },
    onInputChild: function(event) {
      if (this.child_group.name == ""){
        this.grandchild_group.show = false
      } else {
        this.grandchild_group.show = true
      }
    },
    createGroup: function(e) {
      axios
        .post("/groups.json", {company: this.admin_group, parent_group: this.parent_group, child_group: this.child_group, grandchild_group: this.grandchild_group})
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            } else {
              this.openModal();
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
    releaseThanks: function(e) {
      axios
        .get("/letters/timer.json")
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            if (response.data && response.data.errors) {
            this.errors = response.data.errors;
            } else {
              this.openModal();
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
    }
  },
}
</script>

<style scoped>
* {
  font-size: 14px;
}

main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
  margin-left: 35%;
}

h2 {
  font-size: 16px;
  padding-left: 20px;
  border-bottom: inset 2px #ff0000;
}

section {
  width: 80%;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  padding: 10px 30px;
  margin: 35px auto;
}

form {
  padding: 20px;
}

.hidden {
  display: none;
}

/* ポップアップ */
.overlay{
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

.close-btn {
  display: block;
  margin: auto;
  width: 200px;
  height: 50px;
  border-radius: 25px;
  border: none;
}

/* 会社登録 */
.company {
  height: 330px;
}

.company__form {
  display: flex;
  padding-top: 40px;
}

.company__form__boxies {
  width: 83%;
}

.company__form__btn-box {
  display: flex;
  flex-direction: column;
}

.company__form__boxies__box {
  display: flex;
  justify-content: space-between;
}

.form--required {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.form--required::after {
  width: 35px;
  text-align: center;
  content: '必須';
  color: #fff;
  border-radius: 5px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
}

.form--optional {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.form--optional::after {
  width: 35px;
  text-align: center;
  content: '任意';
  color: #fff;
  border-radius: 5px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
}

.company__form__boxies__box__text {
  margin: 0 40px 20px 0;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.company__form__submit {
  width: 100px;
  height: 90px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
  margin-top: 20px;
}

/* 部署登録 */

.group {
  height: 300px;
}

.group--admin::after {
  content: "※管理者のみ";
  font-size: 10px;
  color: gray;
}

.group__form {
  display: flex;
  padding-top: 40px;
}

.group__form__boxies {
  width: 83%;
}

.group__form__boxies__box {
  display: flex;
  justify-content: space-between;
}

.group__form__boxies__box__text {
  margin: 0 40px 20px 0;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.group__form__submit {
  width: 100px;
  height: 150px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
  margin-top: 20px;
}
</style>
