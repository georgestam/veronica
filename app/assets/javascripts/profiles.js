// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){

  // This will update the progress bar
  var progress = $("#progress").text();
  $('#account-progress').attr('aria-valuenow', progress).css('width',progress+'%');


  // This will dynamically switch between tabs
  $(".tab").on("click", function(e){
    // Change active tab
    $(".tab").removeClass("active");
    $(this).addClass("active");

    // Hide all tab content
    $(".tab-content").addClass("hidden");

    // Show target tab
    var tabSelector = $(this).data("target");
    $(tabSelector).removeClass("hidden");
  });


  if ($('#email-verification').val()){
    $("#email").addClass("verified");
  };

  if ($('#payment-verification').val()){
    $('#payment').addClass("verified");
  };

  if ($('#student-id-verification').val()){
    $("student_id").addClass("verified");
  };

  if ($('#car-verification').val()){
    $('car').addClass("verified");
  };

});

