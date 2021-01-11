<template>
  <main>
    <div>
      <div class="main">
        <div class="conts">
          <ul>
            <li class="conts_title">
              <div class="name">氏名</div>
              <div class="email">メールアドレス</div>
              <div class="group">組織内のグループ名</div>
              <div class="status">権限</div>
              <div class="status">権限変更</div>
              <button class="change_btn bg_none"></button>
              <button class="delete_btn bg_none"></button>                        
            </li>
            <li class="cont" v-for="data in users">
              <FormLists :user="data" v-if="data.request == true"></FormLists>
              <RequestList :user="data" v-else></RequestList>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'avatar.png';
import FormLists from './FormLists.vue';
import RequestList from './RequestList.vue';
export default {
  data: function () {
    return{
      users: [
        // company: {
        //   id: "",
        //   name: ""
        // },
        // parent_group: {
        //   id: "",
        //   name: ""
        // },
        // children_group: {
        //   id: "",
        //   name: ""
        // },
        // grandchildren_group: {
        //   id: "",
        //   name: ""
        // },
        // user: {
        //   avatar: {url: "/uploads/user/avatar/1/kuma_happy.png"},
        //   email: "hiroki.kumagai@di-v.co.jp",
        //   id: 1,
        //   name: "熊谷裕樹",
        //   status: "管理者",
        //   request: false
        // }
      ]
    }
  },
  components: {FormLists, RequestList},
  created() {
    axios
    .get('/api/admin/users/index.json')
    .then(response => {
      if (Object.keys(response.data).length != 0){
        for(let data of response.data){
          this.$data.users.push(data)
        }
      }
    });
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  }
}
</script>

<style scoped>

</style>
