<template>
    <a :href="navUrl" class="gNav-section__text">{{ navText }}</a>
</template>

<script>

export default {
  props: [ 'text', 'url' ],
  data: function(){
    return {
      navText: this.text,
      navUrl: this.url
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
