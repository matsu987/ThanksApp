import Vue from 'vue'
import EditUser from '../components/user_edit/UserEdit.vue'

document.addEventListener('DOMContentLoaded', () => {
  const editUser = new Vue({
    render: h => h(EditUser)
  }).$mount()
  document.body.appendChild(editUser.$el)
})