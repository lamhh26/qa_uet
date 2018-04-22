App.cable.subscriptions.create('NotificationsChannel', {
  connected: function() {
  },
  disconnected: function() {
  },
  received: function(data) {
    $('.notification-container').prepend(data.html);
    $('.dropdown-container-notification .notification-card').last().remove();
    return this.update_counter(data.counter);
  },
  update_counter: function(counter) {
    if ($('#noti-counter').length === 0) {
      var notiCounterElement = '<span class="label label-primary noti-number" id="noti-counter">' +
        counter + '</span>';
      $('.dropdown-toogle-notification').find('a').append(notiCounterElement);
    } else {
      $('#noti-counter').html(counter);
    }
  }
});
