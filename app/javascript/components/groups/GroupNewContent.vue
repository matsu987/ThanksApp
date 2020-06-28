<template>
  <main>
    <div v-if='current_company.name != ""'>
      <section class="company">
        <h2>会社情報</h2>
        <form class="company__form" @submit.prevent="updateCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="company__form__boxies__box--required">会社名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box--optional">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box--optional">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box--optional">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
          </div>
          <input v-if="current_company.admin" type="submit" value="編集" class="company__form__submit" >
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
                <div class="company__form__boxies__box--required">会社名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box--optional">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box--optional">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box--optional">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
          </div>
          <input type="submit" value="登録" class="company__form__submit" >
        </form>
      </section>
    </div>

    <div v-if="current_company.admin">
      <section class="group">
        <h2 class="group--admin">新部署登録</h2>
        <form class="group__form">
          <div class="group__form__boxies">
            <div class="group__form__boxies__box">
              <label>会社登録</label>
              <select class="group__form__boxies__box__text">
                <option value="">選択してください</option>
              </select>
            </div>
            <div class="group__form__boxies__box">
              <label>部署登録</label>
              <select class="group__form__boxies__box__text">
                <option value="">選択してください</option>
              </select>
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
        phone_number: ''
      },
      current_company: {
        id: '',
        name: '',
        post_number: '',
        address: '',
        phone_number: '',
        admin: false
      }
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
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  },
  methods: {
    createCompany: function(event) {
      axios
        .post("/companies", this.company)
        .then(response => {
          this.errors = '';
          if (response.status === 200){
            document.location.reload()
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
    updateCompany: function(event) {
      let url = "/companies/" + this.current_company.id + ".json"
      axios
        .patch(url, this.current_company)
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

/* 会社登録 */
.company {
  height: 300px;
}

.company__form {
  display: flex;
  padding-top: 40px;
}

.company__form__boxies {
  width: 83%;
}

.company__form__boxies__box {
  display: flex;
  justify-content: space-between;
}

.company__form__boxies__box--required {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.company__form__boxies__box--required::after {
  width: 35px;
  text-align: center;
  content: '必須';
  color: #fff;
  border-radius: 5px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
}

.company__form__boxies__box--optional {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.company__form__boxies__box--optional::after {
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
  height: 120px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
  margin-top: 30px;
}

/* 部署登録 */

.group {
  height: 180px;
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
  height: 50px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
  margin-top: 20px;
}
</style>
