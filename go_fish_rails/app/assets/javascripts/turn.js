$(document).ready(function(){
  $("#player0 .hand img").on("click", function(event){
    $("#hidden_rank").val($(event.target).data("rank"));
    $("#player0 .hand img").css("border", "none")
    $(event.target).css("border", "2px solid yellow")
    if($("#hidden_opponent").val() != "none") {
      $("#hidden").submit()
    }
  })
  $(".opp .name").on("click", function(event){
    $("#hidden_opponent").val($(event.target).data("id"));
    $(".opp .name").css("color", "black")
    $(event.target).css("color", "yellow")
    if($("#hidden_rank").val() != "none") {
      $("#hidden").submit()
    }
  })
})
