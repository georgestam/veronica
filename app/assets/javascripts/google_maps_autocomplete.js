$(document).ready(function() {
  $('.autocomplete').each(function(i, item) {
    var autocomplete = new google.maps.places.Autocomplete(item, { types: ['geocode'] });
    google.maps.event.addDomListener(item, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  });
});


