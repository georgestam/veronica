// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
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
});

