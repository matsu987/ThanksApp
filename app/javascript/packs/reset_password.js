import Vue from 'vue'
import ResetPassword from '../components/reset_password/ResetPassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const resetPassword = new Vue({
    render: h => h(ResetPassword)
  }).$mount()
  document.body.appendChild(resetPassword.$el)
})