import Vue from 'vue'
import TransmissionsIndex from '../TransmissionsIndex.vue'

document.addEventListener('DOMContentLoaded', () => {
  const transmissionsIndex = new Vue({
    render: h => h(TransmissionsIndex)
  }).$mount()
  document.body.appendChild(transmissionsIndex.$el)
})