import Vue from 'vue'
import AdminTop from '../components/admin/AdminTop.vue'

document.addEventListener('DOMContentLoaded', () => {
  const adminTop = new Vue({
    render: h => h(AdminTop)
  }).$mount()
  document.body.appendChild(adminTop.$el)
})