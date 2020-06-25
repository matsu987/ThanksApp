<template>
  <div class="gNav-section__link" v-on:click="onclick" :class="{active: isActive}">
    <checkBox></checkBox>
    <navName :text="navText"></navName>
  </div>
</template>

<script>
import axios from 'axios';
import checkBox from 'components/shared/parts/checkBox.vue'
import navName from 'components/shared/parts/navName.vue'

export default {
  props: [ 'currentTabName', 'tabName', 'text' ],
  components: { checkBox ,navName},
  created: function () {
  // 現在のheaderTabの名前("mypageなど")、NavBtnに渡すtabの名前、NavBtnに渡すtabのテキストをpropで受け取る。  
    if ( this.currentTabName == this.tabName ) { this.isActive = true }; 
  },
  data: function(){
    return {
      currentTab: this.currentTabName,
      navTab: this.tabName,
      navText: this.text,
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

  .gNav-section__link.active .gNav-section__btn{
    background: linear-gradient(121.55deg, #F9516F 11.31%, #FF8F6B 87.66%);
  }
  .gNav-section__link.active .gNav-section__text{
      color: #FF7C00;
      background: -webkit-linear-gradient(121.55deg, #F9516F 11.31%, #FF8F6B 87.66%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
  }
</style>
