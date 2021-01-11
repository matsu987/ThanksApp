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
          <p class="success-message" v-if="errors.length == 0">更新が完了しました！<br><span class="sub-message"></span></p>
          <button class="close-btn" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </div>

    <section class="user">
      <h2>基本情報</h2>
      <form class="user__form" @submit.prevent="updateUser">
        <div class="user__form-boxies">
          <div class="user__form-boxies-profile">
            <label for="avatar" class="user__form-boxies-profile-avatar">
              <p>プロフィール画像</p>
              <img v-if="confirmedImage" class="avatar-img" :src="confirmedImage">
              <!--<img v-else-if="avatar" class="avatar-img" :src="avatar">-->
              <img v-else class="avatar-img" src="~avatar.png">
            </label>
            <input type="file" class="hidden" id="avatar" accept="image/jpeg, image/png" @change="confirmImage"/>
          </div>
          <div class="user__form-boxies-box">
          　<label>姓</label>
            <input type="text" class="user__form-boxies-box-text" v-model="current_user.family_name" :placeholder="current_user.family_name">
          </div>
          <div class="user__form-boxies-box">
            <label>名</label>
            <input type="text" class="user__form-boxies-box-text" v-model="current_user.given_name" :placeholder="current_user.given_name">
          </div>
        </div>
        <input type="submit" value="変更" class="user__form-submit" >
      </form>
    </section>

    <section class="login">
      <h2>ログイン情報</h2>
      <form class="login__form" @submit.prevent="updateLogin">
        <div class="login__form-boxies">
          <div class="login__form-boxies-box">
            <label>メールアドレス</label>
            <input type="email" class="login__form-boxies-box-text" v-model="current_user.email" :placeholder="current_user.email">
          </div>
          <div class="login__form-boxies-box">
            <label>パスワード</label>
            <input type="password" class="login__form-boxies-box-text" autocomplete="new-password" v-model="current_user.password">
          </div>
        </div>
        <input type="submit" value="変更" class="login__form-submit">
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
    .get('/api/users/login.json')
    .then(response => {
      this.$data.current_user = response.data
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
/* * {
  font-size: 14px;
} */

</style>
