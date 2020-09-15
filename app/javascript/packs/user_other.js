import Vue from 'vue'
import OtherUser from '../components/users/OtherUser.vue'

document.addEventListener('DOMContentLoaded', () => {
  const otherUser = new Vue({
    render: h => h(OtherUser)
  }).$mount()
  document.body.appendChild(otherUser.$el)
})