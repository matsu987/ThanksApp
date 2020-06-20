<template>
  <main id="app" class="container">
    <div class="main-conts">
      <SignUpContents></SignUpContents>
    </div>
  </main>
</template>

<script>
import SignUpContents from 'components/sign_up/SignUpContents.vue';

export default {
  components: {
    SignUpContents
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
