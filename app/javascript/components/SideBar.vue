<template>
  <div class="side-bar">
    <transition-group enter-active-class="animated fadeInUp" leave-active-class="animated fadeOutUp" appear>
      <li v-for="(thank, index) in sidebarThanks.thanks" :key="thank.id">
        <a :href="sidebarThanks.editUrls[index]">
          <div class="sended-thanks-box">
            <div class="icon-box">
            <img v-if="sidebarThanks.receivers[index].avatar" class="logo" :src="sidebarThanks.receivers[index].avatar">
            <img v-else class="logo" src="~person.png">
            </div>
            <div class="sended-message-box">
              <div class="reciver-box">
                <p class="receiver-name">{{sidebarThanks.receivers[index].name}}<span class="blank"></span>さん</p>
                <p class="thanks-message">{{thank.text}}</p>
              </div>
            </div>
            <div class="status-box">
                公開前
            </div>
          </div>
        </a>
      </li>
    </transition-group>
  </div>
</template>

<script>
import axios from 'axios';
import 'person.png'

export default {
  props: ["sidebarThanks"],
  data: function () {
    return {
    }
  },
  created() {
    axios
      .get('/thanks.json')
      .then(response => {
        var thanks = response.data.send_thanks
        this.sidebarThanks.thanks = thanks
        this.sidebarThanks.receivers = response.data.receivers
        var array = []

        thanks.forEach(thank => {
          var url = "/thanks/" + thank.id + "/edit"
          array.push(url);
        });
        this.sidebarThanks.editUrls = array
      });
  }
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
  margin-top: 15%;
  border-radius: 999px;
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
  width: 13.5em;
  margin-top: 3%;
  text-overflow: ellipsis;
  word-break: break-word;
  height: 60px;
  overflow: hidden;
}

.status-box {
  text-align: center;
  border-left: dotted 2px black;
  background-color: #C4C4C4;
  padding-top: 15px;
}

.icon-box {
  padding: 0 5px;
}

li {
  list-style: none;
}

p {
  font-size: 14px;
}
</style>
