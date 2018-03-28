$(document).ready(function() {
  $('.toggleable').on('shown.bs.collapse', function() {
    scrollCenter(this);
    $(this).find('textarea').focus();
  })

  $('.toggleable').on('show.bs.collapse', function() {
    $('.toggleable').not($(this)).collapse('hide');
  })
});
