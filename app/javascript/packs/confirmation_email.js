import Vue from 'vue'
import ConfirmarionEmail from '../ConfirmarionEmail.vue'

document.addEventListener('DOMContentLoaded', () => {
  const confirmationEmail = new Vue({
    render: h => h(ConfirmarionEmail)
  }).$mount()
  document.body.appendChild(confirmationEmail.$el)
})