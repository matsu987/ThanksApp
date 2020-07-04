import Vue from 'vue'
import Send from '../components/letters/send/Send.vue'

document.addEventListener('DOMContentLoaded', () => {
  const send = new Vue({
    render: h => h(Send)
  }).$mount()
  document.body.appendChild(send.$el)
})