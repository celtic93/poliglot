$(document).ready((function($) {
  let myWidth = (150 - parseInt($('#myBar').text(), 10)) / 1.5;
  $('#myBar').width(myWidth + '%');
}));
