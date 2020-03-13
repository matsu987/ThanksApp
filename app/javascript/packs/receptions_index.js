import Vue from 'vue'
import ReceptionsIndex from '../ReceptionsIndex.vue'

document.addEventListener('DOMContentLoaded', () => {
  const receptionsIndex = new Vue({
    render: h => h(ReceptionsIndex)
  }).$mount()
  document.body.appendChild(receptionsIndex.$el)
})