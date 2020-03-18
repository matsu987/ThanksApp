import Vue from 'vue'
import EditConfirmationPassword from '../components/edit_confirmation_password/EditConfirmationPassword.vue'

document.addEventListener('DOMContentLoaded', () => {
  const editConfirmationPassword = new Vue({
    render: h => h(EditConfirmationPassword)
  }).$mount()
  document.body.appendChild(editConfirmationPassword.$el)
})