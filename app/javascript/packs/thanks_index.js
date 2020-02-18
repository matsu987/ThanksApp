import Vue from 'vue'
import ThanksIndex from '../ThanksIndex.vue'

document.addEventListener('DOMContentLoaded', () => {
  const thanksIndex = new Vue({
    render: h => h(ThanksIndex)
  }).$mount()
  document.body.appendChild(thanksIndex.$el)
})