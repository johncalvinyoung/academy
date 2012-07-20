$(document).ready(function(){
  $("#player0 .hand img").on("click", function(event){
    $("#hidden_rank").val($(event.target).data("rank"));
    $(event.target).css("border", "1px solid yellow")
    if($("#hidden_opponent").val() != "") {
      $("#hidden").submit()
    }
  })
  $(".opp .name").on("click", function(event){
    $("#hidden_opponent").val($(event.target).data("id"));
    $(event.target).css("border", "1px solid yellow")
    if($("#hidden_rank").val() != "") {
      $("#hidden").submit()
    }
  })
})
