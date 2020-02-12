document.addEventListener('DOMContentLoaded', function () {

  // 検索用のHTML
  var buildHTMLGroupSearch = function(){
    // var html = document.createElement("div");
    // html.setAttribute("class", "form_search_group")
    var html = `
    <div class="form_search_group">
      <div class="form_top">
        <ul class="search_list">
          <li>
            <label for="search_units_list">ユニット名</label>
            <select name="unit" id="search_units_list" >
              <option value=null class="search_units_list_add">ユニット名</option>
            </select>
          </li>
          <li>
            <label for="search_groups_list">グループ名</label>
            <select name="group" id="search_groups_list" >
              <option value=null class="search_groups_list_add">グループ名</option>
            </select>
          </li>
          <li>
            <label for="search_teams_list">チーム名</label>
            <select name="team" id="search_teams_list" >
              <option value=null class="search_teams_list_add">チーム名</option>
            </select>
          </li>
          <li>
            <label for="search_rank_list">階級名</label>
            <select name="rank" id="search_ranks_list" >
              <option value=null class="search_ranks_list_add">階級名</option>
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
  // ユニット検索用のoption
  var buildHTMLUnitOption = function (unit) {
    var option = `<option class="${unit.name}" value="${unit.id}">${unit.name}<option>`;
    document.getElementsByClassName("search_units_list_add")[0].insertAdjacentHTML("afterend", option);
    var removeOption = document.getElementsByClassName(unit.name)[0].nextSibling;
    removeOption.remove();
  }

  // グループ検索用のoption
  var buildHTMLGroupOption = function (group) {
    var option = `<option class="${group.name}" value="${group.id}">${group.name}<option>`;
    document.getElementsByClassName("search_groups_list_add")[0].insertAdjacentHTML("afterend", option);
    var removeOption = document.getElementsByClassName(group.name)[0].nextSibling;
    removeOption.remove();
  }

  // チーム検索用のoption
  var buildHTMLTeamOption = function (team) {
    var option = `<option class="${team.name}" value="${team.id}">${team.name}<option>`;
    document.getElementsByClassName("search_teams_list_add")[0].insertAdjacentHTML("afterend", option);
    var removeOption = document.getElementsByClassName(team.name)[0].nextSibling;
    removeOption.remove();
  }

  // ランク検索用のoption
  var buildHTMLRankOption = function (rank) {
    var option = `<option class="${rank.name}" value="${rank.id}">${rank.name}<option>`;
    document.getElementsByClassName("search_ranks_list_add")[0].insertAdjacentHTML("afterend", option);
    var removeOption = document.getElementsByClassName(rank.name)[0].nextSibling;
    removeOption.remove();
  }

  // グループ検索ボタンを押してイベント発火させる。
  document.getElementById("search_group").addEventListener('click', function(){
    // グループ検索用のhtmlを追加
    var html = buildHTMLGroupSearch();
    // afterendはオプションの一つで直後に追加という意味。
    // insertAdjacentHTMLメソッドはjQueryでいうappendメソッド
    document.getElementById("app").insertAdjacentHTML("afterend", html);

    // ユニット一覧を取得する。
    $.ajax({
      url: "/search/units/index",
      dataType: "json",
      data: { input: "" }
    })
    .done(function (units) {
      units.forEach(function (unit) {
        buildHTMLUnitOption(unit);
      });
    })

    // グループ一覧を取得する。
    $.ajax({
      url: "/search/groups/index",
      dataType: "json",
      data: { input: "" }
    })
    .done(function(groups){
      groups.forEach(function(group){
        buildHTMLGroupOption(group);
      });
    })

    // チーム一覧を取得する。
    $.ajax({
      url: "/search/teams/index",
      dataType: "json",
      data: { input: "" }
    })
      .done(function (teams) {
        teams.forEach(function (team) {
          buildHTMLTeamOption(team);
        });
      })

    // ランク一覧を取得する
    $.ajax({
      url: "/search/ranks/index",
      dataType: "json",
      data: { input: "" }
    })
      .done(function (ranks) {
        ranks.forEach(function (rank) {
          buildHTMLRankOption(rank);
        });
      })

    //グループ検索 
    // document.getElementById("search_group").addEventListener('change', function(){
    //   $.ajax()
    //   .done()
    //   .fail();
    // }, false);

    // 階級検索
    // document.getElementById("search_rank").addEventListener('change', function () {
    //   $.ajax()
    //   .done()
    //   .fail();
    // }, false);

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