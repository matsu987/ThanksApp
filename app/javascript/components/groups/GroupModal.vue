<template>
  <div id="overlay" v-show="showContent">
    <div id="modal-content">
      <div v-show="modalChoise">
          <p class="tutorial-text">どちらのチュートリアルを確認しますか？</p>
          <div class="tutorial-btns">
            <button class="tutorial-btn" v-on:click="RegisterModal">組織登録方法</button>
            <button class="tutorial-btn" v-on:click="JoinModal">グループ参加方法</button>
          </div>
          <button class="btn btn-color-close btn-size-xs btn-type-round" v-on:click="closeModal">Close</button>
      </div>
      <div id="join-modal" v-show="showJoinStatus">
        <carousel
          ref="joinCarousel"
          :per-page="1"
          @pageChange="onPageChange"
        >
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal02.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal03.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal04.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal05.png" alt="">
            </div>
          </slide>
        </carousel>
        <div class="tutorial-sub-text">
          <p>①「組織設定」画面にある「組織内のグループ参加申請」から参加したい組織へ申請を依頼してください。</p>
          <p>②「組織内のグループ参加申請」の承認をお待ちください。</p>
          <p>③「新規作成」ボタンから組織内のメンバーへ「感謝のメッセージ」をお送りください。</p>
          <p>④ お送りいただいた「感謝のメッセージ」は月毎に一斉に公開されます。</p>
        </div>
        <div class="tutorial-btns">
          <p
            class="modal-page-btn"
            @click.prevent="backJoinSlide"
          >
            前へ
          </p>
          <p
            class="modal-page-btn"
            @click.prevent="nextJoinSlide"
          >
            次へ
          </p>
        </div>
        <button class="btn btn-color-close btn-size-sm btn-type-round" v-on:click="closeModal">Close</button>
      </div>

      <div id="registaration-modal" v-show="showRegistrationStatus">
        <carousel　
          ref="registerCarousel"
          :per-page="1"
          @pageChange="onPageChange"
        >
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal01.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal02.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal03.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal04.png" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="~community/community-modal05.png" alt="">
            </div>
          </slide>
        </carousel>
        <div class="tutorial-sub-text">
          <p>①「組織設定」画面にある「組織登録」を実施してください。</p>
          <p>② メンバーの方に「組織設定」画面にある「組織内のグループ参加申請」から①で登録した組織へ申請を依頼してください。</p>
          <p>③「管理者設定」画面に届いた「組織内のグループ参加申請」を許可（もしくは取消）をしてください。</p>
          <p>④「新規作成」ボタンから組織内のメンバーへ「感謝のメッセージ」をお送りください。</p>
          <p>⑤「メッセージを公開したい」場合は「組織設定」画面にある「メッセージ公開」ボタンを押してください。</p>
        </div>
        <div class="tutorial-btns">
          <p
            class="modal-page-btn"
            @click.prevent="backRegisterSlide"
          >
            前へ
          </p>
          <p
            class="modal-page-btn"
            @click.prevent="nextRegisterSlide"
          >
            次へ
          </p>
        </div>
        <button class="btn btn-color-close btn-size-xs btn-type-round" v-on:click="closeModal">Close</button>
      </div>
    </div>
  </div>
</template>

<script>
import { Carousel, Slide } from 'vue-carousel';
import axios from 'axios';
import 'community/community-modal01.png';
import 'community/community-modal02.png';
import 'community/community-modal03.png';
import 'community/community-modal04.png';
import 'community/community-modal05.png';

export default {
  components: {
    Carousel,
    Slide
  },
  data: function () {
    return {
      current_user_id: "",
      belong_to_company: {},
      showContent: false,
      showJoinStatus: false,
      showRegistrationStatus: false,
      modalChoise: true
    }
  },
  created(){
  // グループ情報を取得
    axios
    .get('/api/users/login.json')
    .then(user_response => {
      let group_belong_url = `/api/users/${user_response.data.id}/company/belong_to.json`;
      axios
      .get(group_belong_url)
      .then(group_response => {
        this.$data.belong_to_company = group_response.data
        if(!this.$data.belong_to_company.company){
          this.openModal()
        }
      });
    });
  },
  methods:{
    openModal: function(){
      this.showContent = true
      this.joinStatus = true
      this.showRegistrationStatus = false
      this.showJoinStatus = false
    },
    closeModal: function(){
      this.showContent = false
      this.modalChoise = true

    },
    onPageChange: function(index) {
      this.preIndex = index;
    },
    nextRegisterSlide() {
      this.$refs.registerCarousel.goToPage(this.$refs.registerCarousel.getNextPage());
    },
    backRegisterSlide(){
      this.$refs.registerCarousel.goToPage(this.$refs.registerCarousel.getPreviousPage());
    },
    nextJoinSlide() {
      this.$refs.joinCarousel.goToPage(this.$refs.joinCarousel.getNextPage());
    },
    backJoinSlide(){
      this.$refs.joinCarousel.goToPage(this.$refs.joinCarousel.getPreviousPage());
    },
    RegisterModal(){
      this.showRegistrationStatus = true
      this.modalChoise = false
    },
    JoinModal(){
      this.showJoinStatus = true
      this.modalChoise = false
    }
  },
}
</script>

<style scoped>

</style>
