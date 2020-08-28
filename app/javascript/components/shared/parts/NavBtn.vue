<template>
  <div class="gNav-section__link" v-on:click="onclick" :class="{active: isActive}">
    <CheckBox></CheckBox>
    <NavName :url="navUrl" :text="navText"></NavName>
  </div>
</template>

<script>
import axios from 'axios';
import CheckBox from './checkBox.vue'
import NavName from './navName.vue'

export default {
  props: [ 'currentTabName', 'tabName', 'text' , 'url'],
  components: { CheckBox ,NavName},
  created: function () {
  // 現在のheaderTabの名前("mypageなど")、NavBtnに渡すtabの名前、NavBtnに渡すtabのテキストをpropで受け取る。  
    if ( this.currentTabName == this.tabName ) { this.isActive = true }; 
  },
  data: function(){
    return {
      currentTab: this.currentTabName,
      navTab: this.tabName,
      navText: this.text,
      navUrl: this.url,
      isActive: false
    }
  },

  methods: {
    onclick: function(e){
      this.currentTab = this.navTab;
      this.$emit('active', { text: this.currentTab, change: true });
      var li = e.currentTarget.parentNode.parentNode.querySelectorAll(":scope > li");
      for (var i = 0; i < li.length; i++) {
        li[i].firstChild.className= "gNav-section__link"
      }
      e.currentTarget.className = "gNav-section__link active";
    }
  }
}
</script>

<style scoped>

  .gNav-section__link{
    display: flex;
    width: 80%;
    margin: 0 auto;
  }

</style>
