document.addEventListener('DOMContentLoaded', function(){
  $("#search_form").autocomplete({
    source: function (request, response) {
      // 仕込みinputの初期化
      var details = document.getElementById("details")
      var details_child = details.childNodes[0];
      if (details_child){
        details.removeChild(details_child);
      }
      // 
      var suggests = [];
      $.ajax({
        url: "/search/users/index",
        dataType: "json",
        data: { input: request.term },
      })
      .done(function(users){
        users.forEach( function(user){
          // グループ名を検索時に表示させる。
          // 同一名の人が検索できてしまうことを考えると顔写真付きの方がいいかもしれない
          user_profile = { label: user.name,  value: user.name } 
          //
          //

          // 
          // 以下localStrageへの保存方法
          var setjson_user = JSON.stringify(user);
          localStorage.setItem(user.name, setjson_user);
          // 
          // 
          
          // 
          // 検索結果をHTMLに返す
          suggests.push( user_profile);
          return response(suggests);
          // 
          // 
        });
      })
    },
    autoFocus: true,
    delay: 300,
    minLength: 1,
    select: function(e, ui){
      if (ui.item) {

        // 仕込み用のinputタグ生成。user_idを渡す。
        // マツケンさんへ
        // 検索フォームを作成するときにformタグの中に<span id="details"></span>を入れて欲しいです。
        // 仕込みのinputタグを挿入しているので
        var params = document.createElement("input");
        params.setAttribute("type", "hidden");
        params.setAttribute("name", "user[:id]");
        params.setAttribute("class", "search_user_id");
        params.setAttribute("data-name", ui.item.label);
        // localStrageから取得。jsonで扱えるようにするt前にparseメソッドで変換する。
        var getjson_user = localStorage.getItem(ui.item.value);
        var user_details = JSON.parse(getjson_user);
        // 
        params.value = user_details.id;
        document.getElementById("details").appendChild(params);
        // 
        // 
        // 
        // 
      }
    }
  });
}, false);