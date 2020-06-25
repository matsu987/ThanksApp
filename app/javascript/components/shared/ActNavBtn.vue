<template>
  <div class="gNav-section__link" v-on:click="onclick" :class="{active: isActive}">
    <checkBox></checkBox>
    <navName :text="text"></navName>
  </div>
</template>

<script>
import axios from 'axios';
import checkBox from 'components/shared/parts/checkBox.vue'
import navName from 'components/shared/parts/navName.vue'

export default {
  props: [ 'text', 'tab'],
  components: { checkBox ,navName},
  data: function(){
    return {
      current: "",
      isActive: true,
      text: this.text
    }
  },

  methods: {
    onclick: function(e){
      this.current = this.text;
      this.$emit('active', { text: this.current, change: true });
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
