<template>
  <div class="header">
    <img class="logo" src="~logo.png">
    <button class="mypage-btn">マイページ</button>
    <button class="logout-btn">ログアウト</button>
  </div>
</template>

<script>
import 'logo.png'

export default {
}
</script>

<style scoped>
.header {
  display: flex;
  position: relative;
  height: 100px;
  width: 100%;
  background-color: red;
}

.logo {
  height: 100px;
  margin-left: 50px;
}

.mypage-btn {
  position: absolute;
  top: 70px;
  right: 150px;
}
.logout-btn {
  position: absolute;
  top: 70px;
  right: 50px;
}
p {
  font-size: 2em;
  text-align: center;
}
</style>
