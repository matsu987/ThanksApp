<template>
    <p class="gNav-section__text">{{ navText }}</p>
</template>

<script>

export default {
  props: [ 'text' ],
  data: function(){
    return {
      navText: this.text
    }
  },
  methods: {
  }
}
</script>

<style scoped>
  .gNav-section__link.active .gNav-section__text{
      color: #FF7C00;
      background: -webkit-linear-gradient(121.55deg, #F9516F 11.31%, #FF8F6B 87.66%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
  }
</style>
