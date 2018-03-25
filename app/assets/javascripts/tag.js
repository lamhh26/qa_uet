$(document).ready(function() {
  $('#post_all_tags').tagit({
    autocomplete: {
      source: function(req, res) {
        $.get('/tags/search', {name: req.term, except_names: $('#post_all_tags').val()},
          function(data) {
            res(data);
          }
        );
      }
    },
    tagLimit: 5
  });
});
