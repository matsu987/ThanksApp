<template>
  <div class="side-bar">
    <div class="sended-thanks-box">
      <div class="icon-box">
       <img class="logo" src="~momo.jpeg">
       </div>
      <div class="sended-message-box">
        <div class="reciver-box">
          <p class="receiver-name">田中太郎<span class="blank"></span>さん</p>
          <p class="thanks-message">あああああああああああああああああああああああああああああああああ39文字制限<span class="point">...</span></p>
        </div>
      </div>
      <div class="status-box">
          下書き
      </div>
    </div>
    <div class="sended-thanks-box">
    </div>
    <div class="sended-thanks-box">
    </div>
    <div class="sended-thanks-box">
    </div>
    <div class="sended-thanks-box">
    </div>
    <div class="sended-thanks-box">
    </div>
  </div>
</template>

<script>
export default {
}
</script>

<style scoped>
.side-bar {
  height: 83%;
  width: 300px;
  margin: 0 60px;
  background-color: #fff;
  border: 1px solid #555555;
  overflow: scroll;
}

.sended-thanks-box {
    display: flex;
    height: 19.5%;
    border-bottom: dotted 3px  black;
}

.logo {
  height: 80px;
  width: 80px;
  margin-top: 22%;
}

.sended-message-box {
  width: calc(100% - 106px);
}

.receiver-name {
  font-size: 16px;
  margin-top: 5%;
}

.blank {
  margin-right: 5px;
}

.thanks-message {
  margin-top: 3%;
}

.status-box {
    writing-mode: vertical-rl;
    height: 100%;
    text-align: center;
    border-left: dotted 2px black;
    background-color: #C4C4C4;
}

p {
  font-size: 14px;
}
</style>
