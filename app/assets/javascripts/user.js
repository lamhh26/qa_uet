$(document).ready(function() {
  $('#userfilter').keyup(function () {
    $(this).parent('form').submit();
  });

  $('.courses-select').select2({}).on('select2:selecting', function(e){
    window.location = $(this).data('url') + '&course_id=' + e.params.args.data.id;
  });
});
