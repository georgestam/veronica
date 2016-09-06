$(document).ready(function() {
  $('.autocomplete').each(function(i, item) {
    var defaultBounds = new google.maps.LatLngBounds(
      new google.maps.LatLng(52.320806, -1.635384),
      new google.maps.LatLng(52.216257, -1.448107));

    var options = {
      bounds: defaultBounds,
      componentRestrictions: {
        country: 'UK'
      },
      types: ['geocode']
    };

    var autocomplete = new google.maps.places.Autocomplete(item, options);
    google.maps.event.addDomListener(item, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  });
});


