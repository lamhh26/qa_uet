// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/position
//= require jquery-ui/widgets/autocomplete
//= require bootstrap-sprockets
//= require flash
//= require ckeditor/init
//= require tag-it.min
//= require answer
//= require tag
//= require user
//= require comment
//= require pnotify
//= require select2

$.ajaxSetup({
  statusCode: {
    302: function (response) {
      var redirect_url = response.getResponseHeader('X-Ajax-Redirect-Url');
      var message = response.getResponseHeader('X-Ajax-Message');
      if (redirect_url) {
        window.location.href = redirect_url;
      }
      if(message)
        pnotify('Error!', message, 'error');
    }
  }
});

function scrollCenter(element) {
  var elOffset = $(element).offset().top;
  var elHeight = $(element).height();
  var windowHeight = $(window).height();
  var offset;

  if (elHeight < windowHeight) {
    offset = elOffset - ((windowHeight / 2) - (elHeight / 2));
  } else {
    offset = elOffset;
  }
  $('html, body').animate({scrollTop: offset}, 500);
}

function pnotify(title, text, type, hide, addclass) {
  new PNotify({
    title: title,
    text: text,
    type: type || 'success',
    styling: 'bootstrap3',
    addclass: addclass || '',
    hide: hide || true
  });
}
