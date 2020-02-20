<template>
  <div class="password_contents">
    <form action="">
      <div class="form_content">
        <div class="email_form">
          <label for="email">E-Mail</label>
          <input type="email" name="" id="email" placeholder="emailを入力してください">
        </div>
        <div class="password_form">
          <label for="pass">PASS</label>
          <input type="password" name="" id="pass" placeholder="passwordを入力してください">
        </div>
      </div>
      <div class="form_bottom_content">
        <input type="submit" value="ログイン">
          <p>
            <a href="#" class="resetting_pass">
              パスワードを再設定する ▶ ︎
            </a>
          </p>
      </div>
    </form>
  </div>
</template>

<script>

export default {
  data: function(){
    return{
    }
  },
  methods: {
  }
}
</script>

<style scoped>
  .password_contents{
    background-color: #FAFAFA;
    width: 800px;
    height: 400px;
    box-sizing: border-box;
  }
  .form_content{
    margin: 90px 0 40px; 
  }
  .form_content label{
    display: inline-block;
    background-color: #888888;
    width: 100px;
    line-height: 50px;
    color: #FFFFFF;
    font-family: Noto Sans CJK JP;
    font-size: 14px;
    letter-spacing: 0.02em;
    padding-right: 9px;
  }
  .form_content input{
    display: inline-block;
    width: 250px;
    height: 50px;
    background-color: #FFFFFF;
    box-sizing: border-box;
  }
  .form_content .password_form{
    padding-top: 33px;
  }
  .form_bottom_content input{
    width: 200px;
    height: 40px;
    color: #FFFFFF;
    border-radius: 40px;
    background-color: #FFC152;
    filter: drop-shadow(5px 5px 5px rgba(0, 0, 0, 0.25));
  }
  .form_bottom_content .resetting_pass{
    display: inline-block;
    padding-top: 20px;
    color: #888888;
    font-family: Noto Sans CJK JP;
    letter-spacing: 0.02em;
  }
</style>
