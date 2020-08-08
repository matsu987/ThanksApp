<template>
  <main>
    <div>
      <div class="company">
        <table border="1" width="100%" cellspacing="0" cellpadding="5" bordercolor="#333333">
          <tr>
            <th bgcolor="#EE0000"><font color="#FFFFFF">ユーザーID</font></th>
            <th bgcolor="#EE0000" ><font color="#FFFFFF">名前</font></th>
            <th bgcolor="#EE0000" ><font color="#FFFFFF">Email</font></th>
            <th bgcolor="#EE0000"><font color="#FFFFFF">権限</font></th>
            <th bgcolor="#EE0000" ><font color="#FFFFFF">所属部署1</font></th>
            <th bgcolor="#EE0000" ><font color="#FFFFFF">所属部署2</font></th>
            <th bgcolor="#EE0000" ><font color="#FFFFFF">所属部署3</font></th>
          </tr>
          <tr v-for="data in users">
            <td bgcolor="#99CC00" align="right" nowrap>{{data.user.id}}</td>
            <td bgcolor="#FFFFFF" valign="top">{{data.user.name}}</td>
            <td bgcolor="#FFFFFF" valign="top">{{data.user.email}}</td>
            <td bgcolor="#FFFFFF" valign="top" @click="changeStatus(data.user.id, data.company.id, data.user.status)">{{data.user.status}}</td>
            <td bgcolor="#FFFFFF" valign="top" v-if="data.parent_group">{{data.parent_group.name}}</td>
            <td bgcolor="#FFFFFF" valign="top" v-else>なし</td>
            <td bgcolor="#FFFFFF" valign="top" v-if="data.children_group">{{data.children_group.name}}</td>
            <td bgcolor="#FFFFFF" valign="top" v-else>なし</td>
            <td bgcolor="#FFFFFF" valign="top" v-if="data.grandchildren_group">{{data.grandchildren_group.name}}</td>
            <td bgcolor="#FFFFFF" valign="top" v-else>なし</td>
          </tr>
        </table>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'avatar.png';

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
        //   status: "管理者"
        // }
      ]
    }
  },
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
  },
  methods: {
    changeStatus: function(user_id, company_id, status){
      axios
      .patch('/api/admin/users/update.json', {
        user_id: user_id,
        status: status,
        company_id: company_id,
      })
      .then(response => {
        if(response.data.error){
          console.log(response.data.error.text)
        }
        else{
          for(let user of this.$data.users){
            if(user.id == response.data.user.id){
              user.status = response.data.user.status
            }
          }
        }
      });
    }
  }
}
</script>

<style scoped>

</style>
