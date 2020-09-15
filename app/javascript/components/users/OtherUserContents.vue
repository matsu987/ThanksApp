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
          <p class="success-message" v-if="errors.length == 0">登録が完了しました！<br><span class="sub-message"></span></p>
          <button class="close-btn" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </div>

    <section class="user">
      <h2>基本情報</h2>
      <form class="user__form" @submit.prevent="updateUser">
        <div class="user__form__boxies">
          <div class="user__form__boxies__box">
            <label for="avatar" class="user__form__boxies__box__avatar">
              <p>プロフィール画像</p>
              <img v-if="confirmedImage" class="avatar-img" :src="confirmedImage">
              <img v-else-if="avatar" class="avatar-img" :src="avatar">
              <img v-else class="avatar-img" src="~avatar.png">
            </label>
            <input type="file" class="hidden" id="avatar" accept="image/jpeg, image/png" @change="confirmImage"/>
          </div>
          <div class="user__form__boxies__box">
          　<label>姓</label>
            <input type="text" class="user__form__boxies__box__text" v-model="current_user.family_name" :placeholder="current_user.family_name">
          </div>
          <div class="user__form__boxies__box">
            <label>名</label>
            <input type="text" class="user__form__boxies__box__text" v-model="current_user.given_name" :placeholder="current_user.given_name">
          </div>
        </div>
        <input type="submit" value="変更" class="user__form__submit" >
      </form>
    </section>

    <section class="login">
      <h2>ログイン情報</h2>
      <form class="login__form" @submit.prevent="updateLogin">
        <div class="login__form__boxies">
          <div class="login__form__boxies__box">
            <label>メールアドレス</label>
            <input type="email" class="login__form__boxies__box__text" v-model="current_user.email" :placeholder="current_user.email">
          </div>
          <div class="login__form__boxies__box">
            <label>パスワード</label>
            <input type="password" class="login__form__boxies__box__text" autocomplete="new-password" v-model="current_user.password">
          </div>
        </div>
        <input type="submit" value="変更" class="login__form__submit">
      </form>
    </section>

    <section class="group">
      <h2>部署登録</h2>
      <form class="group__form" @submit.prevent="createGroupUser">
        <div class="group__form__boxies">
          <div class="group__form__boxies__box">
            <label>
              <div class="form--required">会社登録</div>
            </label>
            <select class="group__form__boxies__box__text" v-model="selected_company" @change="companyChange">
              <option value="">選択してください</option>
              <option v-for="(group, index) in groups" :key="group.id" :value="group.id">{{group.name}}</option>
            </select>
          </div>
          <div class="group__form__boxies__box" v-show="parent_group_show">
            <label>
              <div class="form--optional">部署登録</div>
            </label>
            <select class="group__form__boxies__box__text" v-model="selected_parentGroup" @change="parentGroupChange">
              <option value="">親部署を選択してください</option>
              <option v-for="(group, index) in group_parents" :key="group.id" :value="group.id">{{group.name}}</option>
            </select>
          </div>
          <div class="group__form__boxies__box" v-show="child_group_show">
            <label>
              <div class="form--optional">部署登録</div>
            </label>
            <select class="group__form__boxies__box__text" v-model="selected_childGroup" @change="childGroupChange">
              <option value="">子部署を選択してください</option>
              <option v-for="(group, index) in group_children" :key="group.id" :value="group.id">{{group.name}}</option>
            </select>
          </div>
          <div class="group__form__boxies__box" v-show="grandchild_group_show">
            <label>
              <div class="form--optional">部署登録</div>
            </label>
            <select class="group__form__boxies__box__text" v-model="selected_grandChildGroup">
              <option value="">孫部署を選択してください</option>
              <option v-for="(group, index) in group_grandchildren" :key="group.id" :value="group.id">{{group.name}}</option>
            </select>
          </div>
        </div>
        <input type="submit" value="登録" class="group__form__submit">
      </form>
    </section>

    <section class="group" v-for="(group, index) in current_groups" :key="group.id">
      <h2>部署情報</h2>
      <form class="group__form" @submit.prevent="deleteGroupUser(group.company.id, group.parent_group.id, group.child_group.id, group.grandchild_group.id)">
        <div class="group__form__boxies">
          <div class="group__form__boxies__box">
            <label>会社名</label>
            <div class="group__form__boxies__box__text" :data-group-id="group.company.id">{{group.company.name}}</div>
          </div>
          <div class="group__form__boxies__box" v-show="group.parent_group.name">
            <label>
              <div class="group-parent">部署名</div>
            </label>
            <div class="group__form__boxies__box__text" :data-group-id="group.parent_group.id">{{group.parent_group.name}}</div>
          </div>
          <div class="group__form__boxies__box" v-show="group.child_group.name">
            <label>
              <div class="group-child">部署名</div>
            </label>
            <div class="group__form__boxies__box__text" :data-group-id="group.child_group.id">{{group.child_group.name}}</div>
          </div>
          <div class="group__form__boxies__box" v-show="group.grandchild_group.name">
            <label>
              <div class="group-grandchild">部署名</div>
            </label>
            <div class="group__form__boxies__box__text" :data-group-id="group.grandchild_group.id">{{group.grandchild_group.name}}</div>
          </div>
        </div>
        <input type="submit" value="削除" class="group__form__submit">
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
      confirmedImage: "",
      groups: [],
      group_parents: [],
      group_children: [],
      group_grandchildren: [],
      current_groups: [],
      selected_company: '',
      selected_parentGroup: '',
      selected_childGroup: '',
      selected_grandChildGroup: '',
      parent_group_show: false,
      child_group_show: false,
      grandchild_group_show: false,
      showContent: false,
      errors: '',

    }
  },
  created() {
    axios
    .get('/users.json')
    .then(response => {
      this.$data.current_user = response.data.current_user
      this.$data.avatar = response.data.avatar
    });

    axios
    .get('/user/groups.json')
    .then(response => {
      this.$data.groups = response.data
    });

    axios
    .get('/user/groups/belongs_group.json')
    .then(response =>{
      this.$data.current_groups = response.data
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
    updateLogin: function(event) {
      let url = "/users/" + this.current_user.id + "/login_update"
      axios
        .patch(url, {email: this.current_user.email, password: this.current_user.password})
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
    companyChange: function(e){
      axios
        .get('/user/groups/search.json', {params: {group_id: this.selected_company}})
        .then(response => {
          this.$data.group_parents = response.data
          this.$data.parent_group_show = true
          this.$data.child_group_show = false
          this.$data.grandchild_group_show = false
        });
    },
    parentGroupChange: function(e){
      axios
        .get('/user/groups/search.json', {params: {group_id: this.selected_parentGroup}})
        .then(response => {
          this.$data.group_children = response.data
          this.$data.child_group_show = true
          this.$data.grandchild_group_show = false
        });
    },
    childGroupChange: function(e) {
      axios
        .get('/user/groups/search.json', {params: {group_id: this.selected_childGroup}})
        .then(response => {
          this.$data.group_grandchildren = response.data
          this.$data.grandchild_group_show = true
        });
    },
    createGroupUser: function(e){
      axios
        .post('/user/groups.json', {
          company_id: this.selected_company,
          parent_group_id: this.selected_parentGroup,
          child_group_id: this.selected_childGroup,
          grandchild_group_id: this.selected_grandChildGroup})
        .then(response => {
          this.openModal();
        });
    },
    deleteGroupUser: function(company_id, parent_group_id, child_group_id, grandchild_group_id){
      axios
        .delete('/user/groups/destroy.json', {
          params: {
            company_id: company_id,
            parent_group_id: parent_group_id,
            child_group_id: child_group_id,
            grandchild_group_id: grandchild_group_id
          }
        })
        .then(response => {
          this.openModal();
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
  height: 200px;
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

/* ユーザー情報 */
.user {
  height: 200px;
}

.user--admin::after {
  content: "※管理者のみ";
  font-size: 10px;
  color: gray;
}

.user__form {
  display: flex;
  padding-top: 20px;
}

.user__form__boxies {
  width: 83%;
}

.user__form__boxies__box {
  display: flex;
  justify-content: space-between;
}

.user__form__boxies__box__avatar {
  display: flex;
  margin-bottom: 10px;
}

.user__form__boxies__box__avatar p {
  line-height: 40px;
}

.avatar-img {
  height: 40px;
  width: 40px;
  margin-left: 200px;
  border-radius: 999px;
}

.user__form__boxies__box__text {
  margin: 0 40px 20px 0;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.user__form__submit {
  width: 100px;
  height: 80px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
  margin-top: 20px;
}

/* ログイン情報 */
.login {
  height: 200px;
}

.login--admin::after {
  content: "※管理者のみ";
  font-size: 10px;
  color: gray;
}

.login__form {
  display: flex;
  padding-top: 40px;
}

.login__form__boxies {
  width: 83%;
}

.login__form__boxies__box {
  display: flex;
  justify-content: space-between;
}

.login__form__boxies__box__text {
  margin: 0 40px 20px 0;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.login__form__submit {
  width: 100px;
  height: 80px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  border: none;
  border-radius: 10px;
  color: #fff;
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

.group__form__boxies__box__text {
  margin: 0 40px 20px 0;
  height: 30px;
  width: 60%;
  padding-left: 20px;
  border: solid 1px #ff0000;
  border-radius: 10px;
}

.group-parent {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.group-parent::after {
  width: 35px;
  text-align: center;
  content: '親';
  color: #fff;
  border-radius: 5px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  margin-left: 20px;
}

.group-child {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.group-child::after {
  width: 35px;
  text-align: center;
  content: '子';
  color: #fff;
  border-radius: 5px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  margin-left: 20px;
}

.group-grandchild {
  width: 100px;
  display: flex;
  justify-content: space-between;
}

.group-grandchild::after {
  width: 35px;
  text-align: center;
  content: '孫';
  color: #fff;
  border-radius: 5px;
  background: linear-gradient(157.74deg, #F9516F 11.31%, #FF8F6B 87.66%);
  margin-left: 20px;
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
