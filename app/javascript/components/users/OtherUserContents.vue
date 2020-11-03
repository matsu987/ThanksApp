<template>
  <main>
    <div>
      <section class="">
        <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSeRaD6XQqnSazzUZi5C9PFDNemASB953EGUQP8GPKi66f-B-g/viewform?embedded=true" width="640" height="610" frameborder="0" marginheight="0" marginwidth="0">読み込んでいます…</iframe>
      </section>

      <section class="">
        <h2>アリレターLP</h2>
        <a href="">
          <img src="">
        </a>
      </section>

      <section class="">
        <button class="btn btn-color-close btn-size-xs btn-width-half btn-type-round" @click="logoutBtn">ログアウト</button>
        <button class="btn btn-color-close btn-size-xs btn-width-half btn-type-round" @click="deleteUser">退会する</button>
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
      current_user: {},
    }
  },
  created() {
    // ログインユーザー取得
    axios
    .get('/api/users/login.json')
    .then(response => {
      if (response.status === 200 ) {
        this.$data.current_user = response.data
      }
    });
  },
  methods: {
    logoutBtn: function(e) {
      e.preventDefault();
      let url = `/users/sign_out`;
      axios
      .delete(url)
      .then(response => {
        document.location.reload()
      });
    },
    deleteUser: function(e) {
      e.preventDefault();
      let url = `/api/users/${this.$data.current_user.id}.json`;
      axios
      .delete(url)
      .then(response => {
        document.location.reload()
      });
    },
  },
}
</script>

<style scoped>
/* 共通 */
* {
  font-size: 14px;
}

main{
  width: calc(100% - 300px);
  background-color: #fff;
  margin-left: 300px;
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

.hidden {
  display: none;
}

</style>
