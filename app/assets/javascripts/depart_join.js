$(function() {

  function buildChild1HTML() {
    var html =
      `<select id="depart_join_child1" name="group_id">
            <option value>---</option>
        </select>`
    return html
  }

  function buildChild2HTML() {
    var html =
      `<select id="depart_join_child2" name="group_id">
            <option value>---</option>
        </select>`
    return html
  }

  function buildChild3HTML() {
    var html =
      `<select id="depart_join_child3" name="group_id">
            <option value>---</option>
        </select>`
    return html
  }

  function appendChild(child) {
    return $("<option>").val($(child).attr('id')).text($(child).attr('name'))
  }

  $(document).on("change", "#depart_join_company", function(e){
    let group_id = $(this).val();
    $.ajax({
      url: "/groups/get_group",
      type: "GET",
      data: {
        group_id: group_id
      },
      dataType: 'json',
    })
    .done(function(groups) {
      if (groups.length != null){
        let html = buildChild1HTML();
        $("#depart_child2").append(html)
        groups.forEach(function(group) {
          let childHTML = appendChild(group);
          $("#depart_join_child1").append(childHTML)
        });
      }
    })
    .fail(function(){
      alert('error');
    })
  })

  $(document).on("change", "#depart_join_child1", function(e){
    let group_id = $(this).val();
    $.ajax({
      url: "/groups/get_group",
      type: "GET",
      data: {
        group_id: group_id
      },
      dataType: 'json',
    })
    .done(function(groups) {
      if (groups.length != null){
        let html = buildChild2HTML();
        $("#depart_child3").append(html)
        groups.forEach(function(group) {
          let childHTML = appendChild(group);
          $("#depart_join_child2").append(childHTML)
        });
      }
    })
    .fail(function(){
      alert('error');
    })
  })

  $(document).on("change", "#depart_join_child2", function(e){
    let group_id = $(this).val();
    $.ajax({
      url: "/groups/get_group",
      type: "GET",
      data: {
        group_id: group_id
      },
      dataType: 'json',
    })
    .done(function(groups) {
      if (groups.length != null){
        let html = buildChild3HTML();
        $("#depart_child4").append(html)
        groups.forEach(function(group) {
          let childHTML = appendChild(group);
          $("#depart_join_child3").append(childHTML)
        });
      }
    })
    .fail(function(){
      alert('error');
    })
  })
});
