<template>
  <div id="overlay" v-show="showContent">
    <div id="modal-content">
      <div v-show="modalChoise">
          <p class="tutorial-text">どちらのチュートリアルを確認しますか？</p>
          <div class="tutorial-btns">
            <button class="tutorial-btn" v-on:click="RegisterModal">コミュニティ登録方法</button>
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
              <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAC3CAMAAAAGjUrGAAAANlBMVEXMzMyWlpbPz8+Tk5OoqKidnZ2Xl5e3t7fBwcHGxsbJycmysrKioqK+vr6/v7+fn5+srKyNjY1tYTcuAAAFO0lEQVR4nO2a64KjIAyFlavidd7/ZTcJitixnc5sLe7O+X6JgsqRhBCsKgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMA/xzhkNE0bSr9QeZTVGc723fDrVVG23qPd3JR+qcJ80oToh9JvVRbRJLMeGSr2d48U1sQ2K76bWBU9taXfqySiidrKYbCkiu7KvVF5bjWpqqZnUX7zQPmsiWp6Mh+j7rX4//msSaU8ndPQZI9hj/KsKG2TRb+BCwd2F6TWrnDd0PBIExkoUzzZUMSfXeL4f3cYvHHaTZ2cpULttDVbKNxSrUDm2E0UDBov56ngdD11rTwh8BNyFQPfuKhgh+OkncijyGspo/XHdll9aL14mnjYzi6GND3r09VLfOOXPilPIU+jRpnhl+lMfPjahJ5FT9Bz9ghu0hd18YeaKDIeN8YjnbsWRaVVEz4Mcwp+51B1bi04v9T3VKtprF7PD1XbrwU9sXKq4/Nq9+x6PrXPX3GsCfdOHMpDTWrjqZ6uZag4L67ZyVBZP7RoMvQcKUe9bMs3rGOt+AhpltkKVbS+qIc/1KQa6MXmrzWx9M2NH8ZOumvpy/tx8BLfxIHCmtS9q103jN6IWKSeGcZBxpRl5do+VWdGblF2bXGsSWOXCOWxJtS/jrsV/OZUqDG3maM7ihfsGJR4jthELrHsjt23IvvTKRxSnS5tOnc0CXS2f0aT2PUq8Biop+XzcnenXJNxOS9r8KXD4rN4LIqhJoeiJlatbHD0d5qkQe51ZgAtd1ccimiSFk9sJct8RgxrtMyznFtvFNidjC/t4rc51iSd/UKT9EGH3AuEWeeauORAORZM027jVvvsszt5VrpwOHdfk+kJH5vCuYZdSAoqyCfoTROzdlFulprwiIhjkWevJURk51LadB5o8oTtbPMDa5LyC2qnie52mmz3WjURj24XQe3ieUvyV/5kCzdZkxRU3GiS5tn9zTZNqilFeSzP9Lre/YxjTdrn5mKTLjzSJH32e5pwKOtiONS5C6Qp7scnX8dsW1TxUJNkYHfHCU9BfaxBR1v8Vojj2J69nn+fJuxFJAUcePH5yu79iLvrnRgxvEcTvmB5eAz2AqZzx3Y4Yoideo8mPGWTrfK30GXXf/I6R5o0Nrm/vSbhJNtpl0nMXCI7fphn48/VvVMTXuVMg2qmFLyV5EgTWb3Hntxo4s/ShFpQ+OrtN/LA53GkCQcJdvN+22iW0hmasPHQSqi7hOkcaSKJryXQ4oBBb8tUW5+kCd/ZcOLFvq5rP+aTJsFPnB1aL8/5tgbn007ShJbS0zzRYHlp735G1GQltOPMiZ+04JVgO+aHKiU5oZM0GcmhWJePyXKwJq5bmU3cddjCa9FhblkvGkDn2U4bc9juAu7k9v+TtC+xItF23c9dZ2hSOGve4eyl5PvNFXYHD/5TcnP2sdSyaeN412KqTtNEspd5/r4gt5po3d/85Jf2qGrbnLUG5DvEJ5zRx++i3O6/x+ngBz+z7GXSqvDT3uhap/nQH5kmVFo0oaNck2yjVdHzsqCVE9u1uYI7IVTOYYUhbpOHWDlrt7/LYelxrawQOn0R03mO+3q9Dkn2X2EmvhC8y3MV07kKQ57hBwzHJ7b0JsbFkF1BmM5KaIKSfw5+9U+5e4Ixc58vPAEtqeI66xJrnYsQl5kYJjmB8xPawZtkhNnW1ozlc9NX4g0rBwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABcjD/sGi1PEyRXJgAAAABJRU5ErkJggg==" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="data:image/png;base64,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" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAATYAAACjCAMAAAA3vsLfAAAAkFBMVEUjRlMfRFEZQE4cQk/08/MhRFL39vbx8PAANUUvTlo3U17u7u4UPkw4VF/Cys2UpKq5wsZzgolKY20pSlfb3+Dn6Ong4+RsfYT9/PvEzM/T2NqKnKJfc3xUa3SxvMAANESdrLGmsreCk5pneYEALT57i5JPZ3BCX2qSn6SOoKajq6/O0tSwtrmapaqAjZN0h48iy6tXAAAHZ0lEQVR4nO3Y2XKruBYGYDQAAgTIjEYMYYghNnb8/m93lgAn2XX6tnequtZ3YQMWEvyWhGzLQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEkEU2tk1ss33s72/wqTm8bRxFbXt734v/rOKPPXvf/1mTOXoc2yqwtsq32qGy47j14+jPKn42Yb+uwrb3S7d+XsrfQlLf9z3f83yfeGmaWp7Zt7ejFpHwCUu9dC8KH8EmJb6fSs/7rsKc8seeOQvuMvT9EF7TFF49PzT3TUI4lJoWjpLEMyxo41Whd7SfkleRn00QyzNXS0i6nQjbaej//dzkx9nhWd7pc0Gv8TX2H1meP8SYn/OHtIbcyStVXehWtHPOupRzxZ1CqerrYqWCKlp27NGIn3U21Itsz45zbttzfT23njqfoT7T2nl6QuU+s60c6rO6KMpq6xrHfbL15GQ9O5WMoRJh0TZwznf5ownij0OW67UUl0qpSBXn4fNciF+IjbsQ26C5ZnE9jl69FlkvLoVb9FI5xqpesQWuntKAwzGu1Cs2YuWuy2v5FVvgaNUNap7PrrvFNprYtMsb0UJjEFsV8EhKxV0HYlNRNKZ1Xb9iq9ygko/V5cObBSc5nbTsNA/2JtLL9VEEa981T2XOLPjtcs5+I7azXobBqs13FgQzS5/9BcZA59xJG7iXpVzXo7fZJHBK+XB0u4zFd29jjRNUfP26dK8fGt/ru8FfqjWxrOV6XVJ7UbmbLZoX/ZxaHxBK/enwbgxJWAXZIoe8SNJ9wisdF3IatOu0dx4MTxjPdDqaYE18CZfFv3SRuLkqTaPzfR4+5D/d2b+KLGXrxbFYyoYKx1mknK4ltcTdub81PPDehDWVyz4dvwdO83Z3IiHEcirTowY58PXC8+U1pcs6TijzhrWhVZTCJKQzePWiyHUL1x2uHpG1Ktwgd3X9lBZdXH5LAudx3DttHPfdEgPEDF2sqhv4yuSdVxdeLIQ1/ShtQtvu8X5z1Jtsy2SOx78fm0UoDeNYwpslHH5q23F4Ukvesof0oXN0Y2vLIxGhs1bCXenbM5H0dX6qnZuf88/XtZvYiCUq3bAo8ojtFblnQ2xq4AEfrvEWWwwJ5pcYWrLEB881z16NsDaDWU0OKnYDdx3jhkHf0/wR5vwiWWsykkJIKR9554cplZMafiE2GBYmNrMhnMBMW04Hl11Ho6RNBvOY7pMjIqGimckPKMRhOnqN0Zk7E9NcvUbpEZsuSuhtP2KL0oxnJN5ii8aR87rZYrNkxd2g+foakkiZ2KJm4G7zNLGxlnPTRCfoBCOSPqIouotmrOO4ZfKzqP7+3Gb9GZsLODy74M5qSSS9DLpSnbf3BKGqmdlvy0eXqag+egc8UwIVaTdnrwN1PBPrTecl/aO3RbR0T+IVm6hWMe2xsSXnw9edQ2zRFlspgkFcTGzfTcgaHrAygkd0/j7V4zVOmLxk0a/ERvw9NhvmNv/9fZvbtti8phXibYnVMeea3kaTZoG5beqzcI9JrryIotV1y6O/mN7GaJpDB1mrlNhpBrHZXqQteZK0jz1b1uuHSGY59Vts1nvmXL7GGTt621rKyZNj31DyaiKYxOis7/Tzdq/u78NZvUtY7bXD4/cGKdli43DDp/hpvuD1Q7ZZNsKad8iORES0tvKRVZNl+Vnl7av+OedPSenKXzOM6W1sqTg8CALnSUkTwZbtFxGslC3Wd6Etb3qkhLByqLeKReZ8fsc2rzDoZLSWDAIbhxMj7dYEjNJBfPIisaho41rcuIIJroK5hJH/u6d/H5m7TKtRkhCWjyrsgjxQolGZeoa97od+1d3esdhFZ30yddEw9FkVb79waKmzTC8iVkrtw1bmG+4+pbw7QZ4pXVPijSOsQ1iidBbNzbW+Pm3ysWr9gNzYoLP1tVwmYZzpmj3r+jqxdFj1+vmzCa/geQ3L8rpp47iux6p4nIL1NwYpa6M8rz4gtiqKqiUyC1zRrHn1XK712GvdH52NjnnezSXMxEMR9eHW2egzL4p8ETBLq2GPbVsiu9mJwkO2Cpwg6mFq9Ma4jhc6r3m+mtji0WZ9lmeDia0viuw7tj4vevaE4k+aqiLX42lvojdNiDIL4niIJ1iKQHx1ld9+5VeC+b3XnMoGHn5p0zRT2pxOp4b5zalZ0iQkCSzrjknLXk6n1gtnK52mxdoHBiz7gMcSOLfd++TJmNJttmRQ9WzGULokSeKZpk6N58POYkPVp2k2PziTspy810BL59MpsUMoAn28hSJLaJpI9yZs6U9J0s42CdsEyjTlvJwm+g+39a8jjO7TAwNmhzKzmqPEgnFI2PfMQUw58/cEo/aPY7Dig4C+ytHN987ejYhtBvXe1OtPD3YUI9/lzW+RreW9vLkYQvZKjiYItW22/4sCZeCQWXEihBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYT+o/4H9ZqcRx9vBD8AAAAASUVORK5CYII=" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQRmtUuH6p1Rh2i_HkQ1LhXGrZYvrMkhU_Agg&usqp=CAU" alt="">
            </div>
          </slide>
        </carousel>
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
              <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAC3CAMAAAAGjUrGAAAANlBMVEXMzMyWlpbPz8+Tk5OoqKidnZ2Xl5e3t7fBwcHGxsbJycmysrKioqK+vr6/v7+fn5+srKyNjY1tYTcuAAAFO0lEQVR4nO2a64KjIAyFlavidd7/ZTcJitixnc5sLe7O+X6JgsqRhBCsKgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMA/xzhkNE0bSr9QeZTVGc723fDrVVG23qPd3JR+qcJ80oToh9JvVRbRJLMeGSr2d48U1sQ2K76bWBU9taXfqySiidrKYbCkiu7KvVF5bjWpqqZnUX7zQPmsiWp6Mh+j7rX4//msSaU8ndPQZI9hj/KsKG2TRb+BCwd2F6TWrnDd0PBIExkoUzzZUMSfXeL4f3cYvHHaTZ2cpULttDVbKNxSrUDm2E0UDBov56ngdD11rTwh8BNyFQPfuKhgh+OkncijyGspo/XHdll9aL14mnjYzi6GND3r09VLfOOXPilPIU+jRpnhl+lMfPjahJ5FT9Bz9ghu0hd18YeaKDIeN8YjnbsWRaVVEz4Mcwp+51B1bi04v9T3VKtprF7PD1XbrwU9sXKq4/Nq9+x6PrXPX3GsCfdOHMpDTWrjqZ6uZag4L67ZyVBZP7RoMvQcKUe9bMs3rGOt+AhpltkKVbS+qIc/1KQa6MXmrzWx9M2NH8ZOumvpy/tx8BLfxIHCmtS9q103jN6IWKSeGcZBxpRl5do+VWdGblF2bXGsSWOXCOWxJtS/jrsV/OZUqDG3maM7ihfsGJR4jthELrHsjt23IvvTKRxSnS5tOnc0CXS2f0aT2PUq8Biop+XzcnenXJNxOS9r8KXD4rN4LIqhJoeiJlatbHD0d5qkQe51ZgAtd1ccimiSFk9sJct8RgxrtMyznFtvFNidjC/t4rc51iSd/UKT9EGH3AuEWeeauORAORZM027jVvvsszt5VrpwOHdfk+kJH5vCuYZdSAoqyCfoTROzdlFulprwiIhjkWevJURk51LadB5o8oTtbPMDa5LyC2qnie52mmz3WjURj24XQe3ieUvyV/5kCzdZkxRU3GiS5tn9zTZNqilFeSzP9Lre/YxjTdrn5mKTLjzSJH32e5pwKOtiONS5C6Qp7scnX8dsW1TxUJNkYHfHCU9BfaxBR1v8Vojj2J69nn+fJuxFJAUcePH5yu79iLvrnRgxvEcTvmB5eAz2AqZzx3Y4Yoideo8mPGWTrfK30GXXf/I6R5o0Nrm/vSbhJNtpl0nMXCI7fphn48/VvVMTXuVMg2qmFLyV5EgTWb3Hntxo4s/ShFpQ+OrtN/LA53GkCQcJdvN+22iW0hmasPHQSqi7hOkcaSKJryXQ4oBBb8tUW5+kCd/ZcOLFvq5rP+aTJsFPnB1aL8/5tgbn007ShJbS0zzRYHlp735G1GQltOPMiZ+04JVgO+aHKiU5oZM0GcmhWJePyXKwJq5bmU3cddjCa9FhblkvGkDn2U4bc9juAu7k9v+TtC+xItF23c9dZ2hSOGve4eyl5PvNFXYHD/5TcnP2sdSyaeN412KqTtNEspd5/r4gt5po3d/85Jf2qGrbnLUG5DvEJ5zRx++i3O6/x+ngBz+z7GXSqvDT3uhap/nQH5kmVFo0oaNck2yjVdHzsqCVE9u1uYI7IVTOYYUhbpOHWDlrt7/LYelxrawQOn0R03mO+3q9Dkn2X2EmvhC8y3MV07kKQ57hBwzHJ7b0JsbFkF1BmM5KaIKSfw5+9U+5e4Ixc58vPAEtqeI66xJrnYsQl5kYJjmB8xPawZtkhNnW1ozlc9NX4g0rBwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABcjD/sGi1PEyRXJgAAAABJRU5ErkJggg==" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="data:image/png;base64,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" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="data:image/png;base64,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" alt="">
            </div>
          </slide>
          <slide>
            <div class="slide-image">
              <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQRmtUuH6p1Rh2i_HkQ1LhXGrZYvrMkhU_Agg&usqp=CAU" alt="">
            </div>
          </slide>
        </carousel>
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
