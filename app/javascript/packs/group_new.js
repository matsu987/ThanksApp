import Vue from 'vue'
import GroupNew from '../components/groups/GroupNew.vue'

document.addEventListener('DOMContentLoaded', () => {
  const groupNew = new Vue({
    render: h => h(GroupNew)
  }).$mount()
  document.body.appendChild(groupNew.$el)
})