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

</style>
