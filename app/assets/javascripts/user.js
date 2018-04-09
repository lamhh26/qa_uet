$(document).ready(function() {
  $('#userfilter').keyup(function () {
    $(this).parent('form').submit();
  })
});
