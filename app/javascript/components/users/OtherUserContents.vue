<template>
  <main>
    <div class="other-contents">
      <section class="">
        <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSfjTDwq0919haawfpVijGTRP60GruFrcp9JoQ964Y5XCp5VVw/viewform?embedded=true" width="100%" height="480" frameborder="0" marginheight="0" marginwidth="0">読み込んでいます…</iframe>
      </section>

      <section class="related-service">
        <h2>アリレターサイト</h2>
        <a href="https://ariletter.co-r-e.net/" target="_blank" rel="noopener noreferrer">https://ariletter.co-r-e.net/</a>
      </section>

      <section class="related-user">
        <button class="btn btn-color-close btn-size-xs btn-width-full btn-type-round" @click="logoutBtn">ログアウト</button>
        <button class="btn btn-color-close btn-size-xs btn-width-full btn-type-round" @click="deleteUser">退会する</button>
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
      if(window.confirm('退会手続きをされますと、アリレターのサービスがご利用できなくなります。再度ご利用いただくには、新規登録が必要となります。本当に退会してもよろしいでしょうか？')) {
        let url = `/api/users/${this.$data.current_user.id}.json`;
        axios
        .delete(url)
        .then(response => {
          document.location.reload()
        });
      }
    },
  },
}
</script>

<style scoped>
/* 共通 */
* {
  font-size: 14px;
}

h2 {
  font-size: 16px;
  padding-left: 20px;
  border-bottom: inset 2px #ff0000;
}

.hidden {
  display: none;
}

.related-user .btn {
  max-width: 400px;
}

.related-user .btn + .btn {
  margin-top: 16px;
}

</style>
