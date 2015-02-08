$(document).ready(function(){
  console.log('Welcome to the api demo!')

  function friendlyDate (datestring) {
    var d = new Date(datestring)
    return d.toString().split(' ').slice(0,4).join(' ');
  }


  $('form#search').on('submit', function(e){
    e.preventDefault();
    var searchTerms = $('form#search input[type=text]').val();

    $.getJSON('/api/v1/search', { q: searchTerms })
      .done(function(data){
        console.log(data);

        var eventHTML = $.map( data, function(event){
          var item = $('<li />'),
              title = $('<h2/>').text(event.title),
              desc = $('<p/>').text(event.description),
              start = $('<p/>').text(friendlyDate(event.start_date)),
              loc = $('<em/>').text(event.location);

          item.append(title);
          item.append(desc);
          item.append(loc);
          item.append(start);
          return item;
        });
        console.log(eventHTML);
        $('#results').html('');
        window.setTimeout(function(){

          $('#results').html($('<ul/>').append(eventHTML));
        }, 1000);
      })

  });

});
