<template>
  <div id="side_bar">
    <div class="side_bar_header" v-on:click="closeMenu">
      <span class="header_line_right"></span>
      <span class="header_line_left"></span>
    </div>
    <div class="side_bar_contents">
      <SideBarContent path="" message="全サプライズサンクス一覧" image="/minnano.png" alt="minnano.png" image-name="ハガキ"></SideBarContent>
      <SideBarContent :path="receptionLink" message="受信一覧" image="/zibunno.png" image-name="手紙"></SideBarContent> 
      <SideBarContent :path="newPath" message="新規作成" image="/send.png" image-name="メモ帳"></SideBarContent>
      <SideBarContent :path="transmissionLink" message="送信一覧" image="/transmission.png" image-name="送信一覧"></SideBarContent> 
      <SideBarContent :path="userLink" message="登録情報編集" image="" image-name=""></SideBarContent> 
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import SideBarContent from 'components/side_bar/SideBarContent.vue';
import 'zibunno.png'
import 'send.png'
import 'minnano.png'

export default {
  components: { SideBarContent },
  data: function () {
    return {
      transmissionLink: "",
      receptionLink: "",
      newPath: "/thanks/new",
      usernLink: ""
    }
  },
  created() {
    axios
    .get('/thanks.json')
    .then(response => {
      this.$data.transmissionLink = `/users/${response.data.current_user.id}/transmissions`
      this.$data.receptionLink = `/users/${response.data.current_user.id}/receptions`
      this.$data.userLink = `/users/${response.data.current_user.id}`
    });
  },
  methods: {
    closeMenu: function(){
      this.$emit('closeMenu', '');
    }
  }
}
</script>

<style scoped>
  #side_bar {
    position: absolute;
    right: 0;
    width: 500px;
    height: 100vh;
    background-color: white;
  }
  .side_bar_header{
    position: relative;
    width: 500px;
    height: 150px;
  }
  .side_bar_contents{
    background-color: white;
  }
  .header_line_right{
    border: 4px solid #888888;
    box-sizing: border-box;
    transform: rotate(-45deg);
    width: 40px;
    height: 0px;
    display: block;
    position: absolute;
    top: 40px;
    right: 150px;
  }
  .header_line_left{
    border: 4px solid #888888;
    box-sizing: border-box;
    transform: rotate(45deg);
    display: block;
    width: 40px;
    height: 0px;
    position: absolute;
    top: 40px;
    right: 150px;
  }
</style>
