// find submit, preventd, 

$(document).ready(function() {
  
  $('form').on('submit', function(e) {
    e.preventDefault();

    var tweetData = $('.tweet_input').serialize();
    $('.tweet_input').val("");
    console.log('in form submit');
    $('.tweet-container').html('Proccessing tweet!...');
    
    console.log(tweetData)
 
    $.ajax({
      type: this.method,
      url: this.action,
      data: tweetData
    }).done(function(server_data) {
      
      console.log(server_data);
      $('.tweet-container').append(server_data);   

    });
    
  });

});