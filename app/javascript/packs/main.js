$(document).ready((function($) {
  let myWidth = (300 - parseInt($('#myBar').text(), 10)) / 3;
  $('#myBar').width(myWidth + '%');
}));
