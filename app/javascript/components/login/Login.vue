<template>
  <main id="app" class="container">
    <div class="main-conts">
      <LoginContents></LoginContents>
    </div>
  </main>
</template>

<script>
import LoginContents from 'components/login/LoginContents.vue';

export default {
  components: {
    LoginContents
  },
  data: function () {
    return {
    }
  }
}
</script>

<style scoped>
.container {
  height: 100vh;
  background: linear-gradient(134.5deg, #F9516F 11.31%, #FF8F6B 87.66%);

}

.main-conts{
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 14px;
  font-family: Noto Sans CJK JP;
}
</style>
