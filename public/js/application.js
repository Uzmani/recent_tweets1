$(document).ready(function() {
  $('.submit_tweet').submit(function(e){
    $('.submit_tweet').prop('disabled', false);
    $('#attempt').html("<p>Processing your Tweet...</p>");
    var url = "/"
    var data = "new_tweet="+$('.new_tweet').val();
    console.log(data);
    $.post(url, data, function(response){
      $('.submit_tweet').prop('disabled', true);
      $('#attempt').html('<p>tweet submitted</p>');
    });
    return false;
  });
});
