<template>
  <div class="side_bar_content">
    <a :href="path" class="content_link">
      <img :src="image" :alt="imageName" class="content_image">
      <span class="content_message">
        {{ message }}
      </span>
    </a>
  </div>
</template>

<script>
export default {
  data: function(){
    return {
    }
  },
  props: [ 'message', 'image', 'imageName', 'path'],
  methods: {
  }
}
</script>

<style scoped>
  .side_bar_content{
    width: 500px;
    height: 70px;
    margin-bottom: 60px;
  }
  a.content_link{
    display: flex;
    position: relative;
    width: 100%;
    height: 100%;
    justify-content: center;
    font-family: Noto Sans CJK JP;
    font-style: normal;
    font-weight: normal;
    font-size: 18px;
    line-height: 70px;
    letter-spacing: 0.05em;
    color: #333333;
  }
  a.content_link:hover{
    font-weight: bold;
    font-size: 18px;
    color: #FFFFFF;
    background: #FFC967;
    border-radius: 999px;
  }
  .content_image{
    height: 100px;
    width: 100px;
    position: absolute;
    top: -15px;
    left: 30px;
  }
  .content_message{
 
    display: inline-block;
  }
</style>
