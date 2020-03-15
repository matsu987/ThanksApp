import Vue from 'vue'
import Login from '../components/login/Login.vue'

document.addEventListener('DOMContentLoaded', () => {
  const login = new Vue({
    render: h => h(Login)
  }).$mount()
  document.body.appendChild(login.$el)
})