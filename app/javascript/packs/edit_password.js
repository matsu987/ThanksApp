import Vue from 'vue'
import EditPassword from '../EditPassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const editPassword = new Vue({
    render: h => h(EditPassword)
  }).$mount()
  document.body.appendChild(editPassword.$el)
})