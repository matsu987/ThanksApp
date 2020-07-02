import Vue from 'vue'
import Receive from '../components/letters/receive/Receive.vue'

document.addEventListener('DOMContentLoaded', () => {
  const receive = new Vue({
    render: h => h(Receive)
  }).$mount()
  document.body.appendChild(receive.$el)
})