$(document).ready(function() {
  $('#userfilter').keyup(function () {
    $(this).parent('form').submit();
  });

  $('.categories-select').select2({
    maximumSelectionLength: 5
  });
});
