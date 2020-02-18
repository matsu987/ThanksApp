<template>
  <div class="side-bar">
    <template v-for="(thank, index) in thanks">
      <a :href="editUrls[index]">
        <div class="sended-thanks-box">
          <div class="icon-box">
          <img class="logo" src="~momo.jpeg">
          </div>
          <div class="sended-message-box">
            <div class="reciver-box">
              <p class="receiver-name">{{receivers[index]}}<span class="blank"></span>さん</p>
              <p class="thanks-message">{{thank.text}}</p>
            </div>
          </div>
          <div class="status-box">
              下書き
          </div>
        </div>
      </a>
    </template>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      thanks: [],
      receivers: [],
      editUrls: []
    }
  },
  created() {
    axios
      .get('/thanks.json')
      .then(response => {
        var thanks = response.data.send_thanks
        this.$data.thanks = thanks
        this.$data.receivers = response.data.receivers

        thanks.forEach(thank => {
          var url = "/thanks/" + thank.id + "/edit"
          var array = this.$data.editUrls
          array.push(url);
        });
      });
  },
  updated() {
    axios
      .get('/thanks.json')
      .then(response => {
        var thanks = response.data.send_thanks
        this.$data.thanks = thanks
        this.$data.receivers = response.data.receivers

        var array = this.$data.editUrls
        
        thanks.forEach(thank => {
          var url = "/thanks/" + thank.id + "/edit"
          array.push(url);
        });
      });
  },
}
</script>

<style scoped>
.side-bar {
  height: 600px;
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
    text-align: center;
    border-left: dotted 2px black;
    background-color: #C4C4C4;
}

p {
  font-size: 14px;
}
</style>
