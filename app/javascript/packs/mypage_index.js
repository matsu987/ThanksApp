import Vue from 'vue'
import MypageIndex from '../MypageIndex.vue'

document.addEventListener('DOMContentLoaded', () => {
  const mypageIndex = new Vue({
    render: h => h(MypageIndex)
  }).$mount()
  document.body.appendChild(mypageIndex.$el)
})