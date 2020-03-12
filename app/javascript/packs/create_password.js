import Vue from 'vue'
import CreatePassword from '../CreatePassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const createPassword = new Vue({
    render: h => h(CreatePassword)
  }).$mount()
  document.body.appendChild(createPassword.$el)
})