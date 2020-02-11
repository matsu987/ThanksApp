document.addEventListener('DOMContentLoaded', function () {
  var buildHTMLGroupSearch = function(){
    // var html = document.createElement("div");
    // html.setAttribute("class", "form_search_group")
    var html = `
    <div class="form_search_group">
      <div class="form_top">
        <ul class="search_list">
          <li>
            <label for="search_group">グループ名</label>
            <select name="group" id="search_group">
              <option value=null>グループ名</option>
            </select>
          </li>
          <li>
            <label for="search_rank">階級名</label>
            <select name="rank" id="search_rank">
              <option value=null>階級名</option>
            </select>
          </li>
          <li>
            <label for="search_form">名前</label>
            <input type="search" name="user[:id]" id="search_form_group_user">
          </li>
        </ul>
        <span id="details_group_user"></span>
      </div>
      <div class="form_result">
      </div>
    </div>`
    return html;
  }
  // グループ検索ボタンを押してイベント発火させる。
  document.getElementById("search_group").addEventListener('click', function(){
    // htmlを追加
    var html = buildHTMLGroupSearch();
    // afterendはオプションの一つで直後に追加という意味。
    // insertAdjacentHTMLメソッドはjQueryでいうappendメソッド
    document.getElementById("app").insertAdjacentHTML("afterend", html);

    // グループ一覧とランク一覧を取得する。
    $.ajax({

    })
    .done()
    .fail();


    //グループ検索 
    document.getElementById("search_group").addEventListener('change', function(){
      $.ajax()
      .done()
      .fail();
    }, false);

    // 階級検索
    document.getElementById("search_rank").addEventListener('change', function () {
      $.ajax()
      .done()
      .fail();
    }, false);












    // user検索する
    // idが重複して発火しなかったので、idを変更
    // detailsをdetails_group_userに
    // search_formをsearch_form_group_userに
    $("#search_form_group_user").autocomplete({
      source: function (request, response) {
        // 仕込みinputの初期化
        var details = document.getElementById("details_group_user")
        var details_child = details.childNodes[0];
        if (details_child) {
          details.removeChild(details_child);
        }
        // 
        var suggests = [];
        $.ajax({
          url: "/search/users/index",
          dataType: "json",
          data: { input: request.term },
        })
          .done(function (users) {
            users.forEach(function (user) {
              // グループ名を検索時に表示させる。
              // 同一名の人が検索できてしまうことを考えると顔写真付きの方がいいかもしれない
              user_profile = { label: user.name, value: user.name }
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
              suggests.push(user_profile);
              return response(suggests);
              // 
              // 
            });
          })
      },
      autoFocus: true,
      delay: 300,
      minLength: 1,
      select: function (e, ui) {
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
          document.getElementById("details_group_user").appendChild(params);
          // 
          // 
          // 
          // 
        }
      }
    });
  }, false);
}, false);