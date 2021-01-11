<template>
  <main>
    <!-- 組織情報 -->
    <div v-if='belong_to_company.company'>
      <section class="company">
        <h2>組織情報</h2>
        <form class="company__form" @submit.prevent="updateCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="form--required">組織名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="belong_to_company.company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="belong_to_company.company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="belong_to_company.company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="belong_to_company.company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box">感謝のメッセージ 一斉公開日時</p>
              </label>
              <input type="datetime" class="company__form__boxies__box__text" v-model="belong_to_company.company.release_time" placeholder="例）2020年01月01日23:00">
            </div>
            <p class="company__form__boxies_sub-text">&#x203B;感謝のメッセージ 一斉公開日時を設定しない場合は毎月末に感謝のメッセージが一斉に公開されます。<br>メッセージを送られたユーザーはメッセージが公開されるまで確認ができません。</p>
          </div>
          <div class="company__form__btn-box">
            <input v-if="belong_to_company.admin" type="submit" value="編集" class="company__form__submit" >
            <button v-if="belong_to_company.admin"  type="button" @click="releaseThanks" class="company__form__submit" >メッセージ<br class="pc_only">公開</button>
          </div>
        </form>
      </section>
    </div>

    <!-- 組織登録 -->
    <div v-else>
      <section class="company">
        <h2>組織登録</h2>
        <form class="company__form" @submit.prevent="createCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="form--required">組織名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box">感謝のメッセージ 一斉公開日時</p>
              </label>
              <input type="datetime" class="company__form__boxies__box__text" v-model="company.release_time" placeholder="例）2020年01月01日23:00">
            </div>
            <p class="company__form__boxies_sub-text">&#x203B;感謝のメッセージ 一斉公開日時を設定しない場合は毎月末に感謝のメッセージが一斉に公開されます。<br>メッセージを送られたユーザーはメッセージが公開されるまで確認ができません。</p>
          </div>
          <input type="submit" value="登録" class="company__form__submit" >
        </form>
      </section>
    </div>

    <!-- グループ情報 -->
    <div v-for="(group, index) in belong_to_company.groups">
      <section class="group">
        <h2 class="">グループ情報&#x203B;申請中</h2>
        <form class="group__form" @submit.prevent="createGroup">
          <div class="group__form__boxies">
            <div class="group__form__boxies__box">
              <label>
                <div class="form--required">組織名</div>
              </label>
              <p class="group__form__boxies__box__text">{{belong_to_company.company.name}}</p>
            </div>
            <div class="group__form__boxies__box" v-show="group.ancestry">
              <label>
                <div class="form--required">組織内のグループ名</div>
              </label>
              <p class="group__form__boxies__box__text">{{group.name}}</p>
            </div>
          </div>
          <!--<input type="submit" value="申請" class="group__form__submit">-->
        </form>
      </section>
    </div>

    <!-- グループ登録 -->
    <div v-if="belong_to_company.admin">
      <section class="group">
        <h2 class="group__admin">グループ登録</h2>
        <form class="group__form" @submit.prevent="createGroup">
          <div class="group__form__boxies">
            <div class="group__form__boxies__box">
              <label>
                <div class="form--required">組織名</div>
              </label>
              <p v-if="belong_to_company.company" class="group__form__boxies__box__text">{{belong_to_company.company.name}}</p>
              <select v-else class="group__form__boxies__box__text">
                <option selected>選択してください</option>
                <option v-for="(company, index) in companies" v-model="company.id" :value="company.id">{{company.name}}</option>
              </select>
            </div>
            <div class="group__form__boxies__box">
              <label>
                <div class="form--required">組織内のグループ名</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="parent_group.name" placeholder="テストグループ">
            </div>
          </div>
          <input type="submit" value="登録" class="group__form__submit">
        </form>
      </section>
    </div>

    <!-- グループ申請 -->
    <div>
      <section class="group">
        <h2 class="">組織内のグループ参加申請<span>例）部署、部門、チームなど、組織の内にある集団</span></h2>
        <form class="group__form" @submit.prevent="joinRequest">
          <div class="group__form__boxies">
            <div class="group__form__boxies__box">
              <label>
                <div class="form--required">組織名</div>
              </label>
              <p v-if="belong_to_company.company" class="group__form__boxies__box__text">{{belong_to_company.company.name}}</p>
              <select v-else class="group__form__boxies__box__text" v-model="selected_company" @change="changeCompany">
                <option selected>選択してください</option>
                <option v-for="(company, index) in companies" v-model="company.id" :value="company.id">{{company.name}}</option>
              </select>
            </div>
            <div class="group__form__boxies__box">
              <label>
                <div class="">組織内のグループ名</div>
              </label>
              <select v-if="belong_to_company.groups" class="group__form__boxies__box__text" v-model="selected_group">
                <option selected>選択してください</option>
                <option v-for="(group, index) in belong_to_company.group_all" v-model="group.id" :value="group.id">{{group.name}}</option>
              </select>
              <select v-else class="group__form__boxies__box__text">
                <option selected>選択してください</option>
                <option v-for="(group, index) in groups" v-model="group.id" :value="group.id">{{group.name}}</option>
              </select>
            </div>
          </div>
          <input type="submit" value="申請" class="group__form__submit">
        </form>
      </section>
    </div>

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
          <button class="btn btn-color-close btn-size-md btn-type-round" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'avatar.png';

export default {
  data: function () {
    return {
      current_user: {},
      company: {
        id: '',
        name: '',
        post_number: '',
        address: '',
        phone_number: '',
        release_time: ''
      },
      selected_company: "",
      selected_group: "",
      companies: [],
      groups: [],
      belong_to_company: {},
      admin_group: {},
      parent_group: {
        name: ''
      },
      showContent: false,
      errors: [],
    }
  },
  created() {
    // ログインユーザーを取得
    axios
    .get('/api/users/login.json')
    .then(response => {
      this.$data.current_user = response.data
    });

    // 組織全て取得
    let group_index_url = `/api/users/${this.$data.current_user.id}/companies.json`;
    axios
    .get(group_index_url)
    .then(response => {
      this.$data.companies = response.data
    });

    // 所属している組織を取得
    let group_belong_url = `/api/users/${this.$data.current_user.id}/company/belong_to.json`;
    axios
    .get(group_belong_url)
    .then(response => {
      this.$data.belong_to_company = response.data
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
      let url = `/api/users/${this.$data.current_user.id}/community.json`
      axios
        .post(url, this.company)
        .then(response => {
          this.errors = '';
          if (response.status === 201){
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
      let url = `/api/users/${this.$data.current_user.id}/community.json`
      axios
        .patch(url, this.belong_to_company)
        .then(response => {
          this.errors = '';
          if (response.status === 201){
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
    createGroup: function(e) {
      let url = `/api/users/${this.$data.current_user.id}/groups.json`
      axios
        .post(url, {company: this.company.id, admin_company: this.belong_to_company, parent_group: this.parent_group})
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
    },
    changeCompany: function(e) {
      let url = `/api/users/${this.$data.current_user.id}/groups.json`
      axios
      .get(url, {params: {company_id: this.$data.selected_company}})
      .then(response => {
        this.$data.groups = response.data
        console.log(this.$data.groups)
      });
    },
    joinRequest: function(e) {
      if (this.$data.belong_to_company.company){
        this.selected_company =  this.$data.belong_to_company.company.id
      }

      let url = `/api/users/${this.$data.current_user.id}/group_users.json`
      axios
        .post(url, {company_id: this.selected_company, group_id: this.selected_group})
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
共通
/* * {
  font-size: 14px;
} */

/* main{
  width: calc(100% - 300px);
  background-color: #fff;
  margin-left: 300px;
} */

/* h2 {
  font-size: 16px;
  padding-left: 20px;
  border-bottom: inset 2px #ff0000;
} */

/* section {
  width: 80%;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  padding: 10px 30px;
  margin: 35px auto;
} */

/* form {
  padding: 20px;
} */

/* .hidden {
  display: none;
} */

/* ポップアップ */
/* .overlay{
  width: 60%;
  height: 50%;
  z-index: 1;
  position: fixed;
  top: 50%;
  left: 50%;
  background-color: transparent;
  border-radius: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: translate(-50%, -50%);
  box-shadow: transparent;
} */

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
