import Vue from 'vue'
import GroupIndex from '../components/groups/GroupIndex.vue'

document.addEventListener('DOMContentLoaded', () => {
  const groupIndex = new Vue({
    render: h => h(GroupIndex)
  }).$mount()
  document.body.appendChild(groupIndex.$el)
})