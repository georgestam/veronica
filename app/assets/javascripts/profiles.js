// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){

  // This will increase the account-progress bar dynamically
  $('#increase-bar').click(function(){
    // The variable below is currently hard-coded and needs to be altered later
    var newprogress = "40";

    $('#account-progress').attr('aria-valuenow', newprogress).css('width',newprogress+'%');

  });

});
