Meteor.subscribe 'currentHackathon'

Meteor.subscribe 'notifications'

$( ->
  window.sawNotifications = false
  $('body').click((e) ->
    if window.sawNotifications
      window.sawNotifications = false
      $('#notifications').removeClass('dropdown-display')
      Meteor.call('resetNotifications')
    $('#newNotificationModal').foundation('reveal', 'close')
  )
)
