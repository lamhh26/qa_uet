$(document).ready(function() {
  $('.datatable').DataTable({
    iDisplayLength: 25,
    order: [[1, 'desc'], [2, 'desc'], [3, 'desc'], [4, 'desc']]
  });
});
