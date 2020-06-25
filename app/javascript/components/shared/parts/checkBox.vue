<template>
  <span class="gNav-section__btn"></span>
</template>

<script>

export default {
  data: function(){
    return {
    }
  },
  methods: {
  }
}
</script>

<style scoped>
  .gNav-section__btn{
    background: #B1B1B1;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin: 0 14px 25px 0;
  }
  
  .gNav-section__link.active .gNav-section__btn{
    background: linear-gradient(121.55deg, #F9516F 11.31%, #FF8F6B 87.66%);
  }
</style>
