<template>
  <main>
    <!-- ポップアップ -->
    <!-- <div class="popup">
      <div class="overlay" v-show="showContent">
        <div class="content">
          <div class="error-message" v-if="errors.length != 0">
            <ul >
              <li><font color="red">{{ errors }}</font></li>
            </ul>
          </div>
          <p class="success-message" v-if="errors.length == 0">登録が完了しました！<br><span class="sub-message">ユーザー設定画面から部署に参加してください</span></p>
          <button class="close-btn" v-on:click="closeModal">Close</button>
        </div>
      </div>
    </div>

    <div v-if='current_company.name != ""'>
      <section class="company">
        <h2>会社情報</h2>
        <form class="company__form" @submit.prevent="updateCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="company__form__boxies__box form--required">会社名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="company__form__boxies__box form--optional">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="current_company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
          </div>
          <input v-if="current_company.admin" type="submit" value="編集" class="company__form__submit" >
        </form>
      </section>
    </div>
    <div v-else>
      <section class="company">
        <h2>会社登録</h2>
        <form class="company__form" @submit.prevent="createCompany">
          <div class="company__form__boxies">
            <div class="company__form__boxies__box">
              <label>
                <div class="form--required">会社名</div>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.name" placeholder="例）株式会社〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="form--optional">郵便番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.post_number" placeholder="例）123-xxxx">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="form--optional">住所</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.address" placeholder="例）東京都〇〇区〇〇〇〇">
            </div>
            <div class="company__form__boxies__box">
              <label>
                <p class="form--optional">電話番号</p>
              </label>
              <input type="text" class="company__form__boxies__box__text" v-model="company.phone_number" placeholder="例）0120-1234-xxxx">
            </div>
          </div>
          <input type="submit" value="登録" class="company__form__submit" >
        </form>
      </section>
    </div>

    <div v-if="current_company.admin">
      <section class="group">
        <h2 class="group--admin">新部署登録</h2>
        <form class="group__form" @submit.prevent="createGroup">
          <div class="group__form__boxies">
            <div class="group__form__boxies__box">
              <label>会社登録</label>
              <select class="group__form__boxies__box__text">
                <option v-model="admin_group.name" :value="admin_group.id">{{admin_group.name}}</option>
              </select>
            </div>
            <div class="group__form__boxies__box" v-show="parent_group.show">
              <label>
                <div class="form--required">部署登録</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="parent_group.name" placeholder="親部署名" @input="onInputParent">
            </div>

            <div class="group__form__boxies__box" v-show="child_group.show">
              <label>
                <div class="form--optional">部署登録</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="child_group.name" placeholder="子部署名" @input="onInputChild">
            </div>

            <div class="group__form__boxies__box"v-show="grandchild_group.show">
              <label>
                <div class="form--optional">部署登録</div>
              </label>
              <input class="group__form__boxies__box__text" type="text" v-model="grandchild_group.name" placeholder="孫部署名">
            </div>
          </div>
          <input type="submit" value="登録" class="group__form__submit">
        </form>
      </section>
    </div> -->
    <div>
      <a href="/admin/users">ユーザー一覧へ</a>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'avatar.png';

export default {
  data: function () {
    return {
    }
  },
  mounted:function(){
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
  }
}
</script>

<style scoped>
* {
  font-size: 14px;
}

main{
  width: 65%;
  height: 100vh;
  background-color: #fff;
  margin-left: 35%;
}
</style>
