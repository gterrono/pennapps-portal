Meteor.subscribe 'notifications'

Meteor.subscribe 'projects'

Meteor.subscribe 'mentors'

Meteor.subscribe 'queue'

Meteor.subscribe 'currentHackathon'

$( ->
  window.sawNotifications = false
  $('body').click((e) ->
    if window.webkitNotifications.checkPermission() isnt 0
      window.webkitNotifications.requestPermission()
    if window.sawNotifications
      window.sawNotifications = false
      $('#notifications').removeClass('dropdown-display')
      Meteor.call('resetNotifications')
    $('#newNotificationModal').foundation('reveal', 'close')
    $('#projectModal').foundation('reveal', 'close')
  )
)

Deps.autorun( ->
  notificationCount = if Meteor.user() then Meteor.user().profile.unseen_num else 0
  if notificationCount and not Meteor.user().profile.admin
    document.getElementById('notification').play()
    if window.webkitNotifications.checkPermission() is 0
      notification = window.webkitNotifications.createNotification(
            '/icon.png', 'New Notification', Notifications.findOne({}, sort: created: -1).text
      )
      notification.show()
    clearInterval(window.blinkInterval)
    window.blinkInterval = window.setInterval(->
      document.title = if document.title is 'PennApps'
        "#{notificationCount} New
        Notification#{if notificationCount isnt 1 then 's' else ''}"
      else
        'PennApps'
    , 750)
)
