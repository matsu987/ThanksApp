<template>
  <div id="app">
    <Header></Header>
    <div class="main-box">
      <SideBar></SideBar>
      <Form></Form>
    </div>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import Header from 'components/Header.vue';
import SideBar from 'components/SideBar.vue';
import Form from 'components/Form.vue';

export default {
  components: {
    Header,Form,SideBar
  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
.main-box {
  display: flex;
  margin-top: 100px;
}
p {
  font-size: 2em;
  text-align: center;
}
</style>
