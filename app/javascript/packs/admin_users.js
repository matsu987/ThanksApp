import Vue from 'vue'
import AdminUsers from '../components/admin/users/AdminUsers.vue'

document.addEventListener('DOMContentLoaded', () => {
  const adminUsers = new Vue({
    render: h => h(AdminUsers)
  }).$mount()
  document.body.appendChild(adminUsers.$el)
})