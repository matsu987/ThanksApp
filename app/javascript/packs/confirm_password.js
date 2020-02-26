import Vue from 'vue'
import ConfirmPassword from '../ConfirmPassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const confirmPassword = new Vue({
    render: h => h(ConfirmPassword)
  }).$mount()
  document.body.appendChild(confirmPassword.$el)
})