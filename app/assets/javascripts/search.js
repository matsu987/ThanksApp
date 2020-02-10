document.addEventListener('DOMContentLoaded', function(){
  $("#search_form").autocomplete({
    source: function (request, response) {
      var suggests = [];
      $.ajax({
        url: "/search/users/index",
        dataType: "json",
        data: { input: request.term },
      })
      .done(function(users){
        users.forEach( function(user){
          console.log(user);

          // グループ名を検索時に表示させる。
          // 同一名の人が検索できてしまうことを考えると顔写真付きの方がいいかもしれない
          //
          user_profile = `${user.name} : ${user.id}`; 
          //
          //
          //
          suggests.push( user_profile );
          console.log( suggests );
          response( suggests );
        });
      })
    },
    autoFocus: true,
    delay: 300,
    minLength: 1
  });

}, false);