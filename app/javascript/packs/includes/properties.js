$(function(){

  $("#show-tel").on("click", function(){
    var $this = $(this);
    $this.find("span").text( $this.data("telephone"));
  })

  $("#toggleDetails").on("click",function(){
    var details = $("#prop-details");
    console.log("clicked");
    details.toggleClass("open");
    if(details.hasClass("open")){
      console.log('class found')
      $(this).text("Show less");
    }else{
      $(this).text("Show more");

    }
  })
  console.log("test")

  $("#send-message-to-agent").on("click",function(){
    var agent_id = $("#agent_id").val(),
      first_name = $("#message-first-name").val(),
      last_name = $("#message-last-name").val(),
      email = $("#message-email").val(),
      message = $("#message-text").val();

    $.ajax({
      url:"/agent/message",
      method: "POST",
      dataType: "json",
      data: {
        agent_id: agent_id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        message: message
      },
      success: function(data){
        $('#contact-modal form').remove();
        $('#send-message-to-agent').remove();
        $('#contact-modal .modal-body').html("<p>Your message has been sent successfully!</p>");
      }
    });
  });

  $('#contact-modal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var modal = $(this);
  })

});
