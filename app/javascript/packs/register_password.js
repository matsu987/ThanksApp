import Vue from 'vue'
import RegisterPassword from '../RegisterPassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const registerPassword = new Vue({
    render: h => h(RegisterPassword)
  }).$mount()
  document.body.appendChild(registerPassword.$el)
})