document.addEventListener('DOMContentLoaded', function(){
  var result = document.getElementById('result');

  var addUser = function(user){
    var div = document.createElement('div');
    div.textContent = user.name;
    div.setAttribute('class', 'add');
    result.append(div);
  }

  document.getElementById('search_form').addEventListener('keyup', function(){
    var input = document.getElementById('search_form').value;
    var url = "/search/users/index"

    $.ajax({
      url: url,
      type: 'get',
      dataType: 'json',
      data: {input: input},
    })
    .done(function(users){
      users.forEach(function(user){
        addUser(user);

        var add_users = document.getElementsByClassName('add')

        for (let i = 0; i < add_users.length; i++) {

          //クリックイベントでアラートを表示する
          add_users[i].addEventListener('click', function () {
            console.log(i + `をクリックしました`);

          }, false);
        }

        
      });
    })
    .fail(function(){
      console.log("error") 
    })
      }, false);
  

}, false);

  //名前付き関数リテラルを定義する。
  // var btn_click = function () {
  //   console.log("ボタンがクリックされた。");
  // }
  // new Vue({
  //   el: '#app',
  //   data: {
  //     message: 'みなさん、こんにちは！',
  //     flag: false,
  //     email: 'KUMAGAi.hiroki@di-v.co.jp',
  //     current: new Date().toLocaleString()
  //   },
  //   computed: {
  //     localEmail: function () {
  //       return this.email.split('@')[0].toLowerCase();
  //     },
  //     randomc: function(){
  //       return Math.random(this.current);
  //     }
  //   },
  //   methods: {
  //     onclick: function(){
  //       this.current = new Date().toLocaleString();
  //     },
  //     randomm: function(){
  //       return Math.random();
  //     }
  //   }

  // })

      // var xhr = new XMLHttpRequest();
    // xhr.onreadystatechange = function(){
    //   if (xhr.readyState === 4){ //通信が完了した時
    //     if (xhr.status === 200){ //通信が成功した時
    //       result.textContent = xhr.responseText;
    //     } else{                  //通信が失敗した時
    //       result.textContent = 'サーバーエラーが発生しました。'
    //     }
    //   } else{                    //通信が完了する前
    //     result.textContent = '通信中...';
    //   }
    // };
    // xhr.open('get', url, true);
    // xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
    // xhr.setRequestHeader('X-CSRF-Token', token); // 追加
    // xhr.send(input);