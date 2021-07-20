$(document).ready((function($) {
  let myWidth = (100 - parseInt($('#myBar').text(), 10)) / 1;
  $('#myBar').width(myWidth + '%');
}));
