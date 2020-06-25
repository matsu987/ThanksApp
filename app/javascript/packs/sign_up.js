import Vue from 'vue'
import SignUp from '../components/sign_up/SignUp.vue'

document.addEventListener('DOMContentLoaded', () => {
  const sign_up = new Vue({
    render: h => h(SignUp)
  }).$mount()
  document.body.appendChild(sign_up.$el)
})