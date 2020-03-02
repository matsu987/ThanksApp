import Vue from 'vue'
import InputPassword from '../InputPassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const inputPassword = new Vue({
    render: h => h(InputPassword)
  }).$mount()
  document.body.appendChild(inputPassword.$el)
})