#All subscriptions
Meteor.subscribe 'notifications'

Meteor.subscribe 'myNotifications'

Meteor.subscribe 'projects'

Meteor.subscribe 'mentors'

Meteor.subscribe 'queue'

Meteor.subscribe 'currentHackathon'

Meteor.subscribe 'questions'

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

#User notifications
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

#Unanswered question notifications go here
Deps.autorun( ->
  unansweredCount = if Meteor.user() then Meteor.user().profile.unanswered_num else 0
  console.log Meteor.user()?.profile?.unanswered_questions
  if unansweredCount and Meteor.user().profile.admin
    document.getElementById('notification')?.play()
    if window.webkitNotifications.checkPermission() is 0
      Deps.nonreactive(->
        notification = window.webkitNotifications.createNotification(
          '/icon.png', 'Latest Question', Meteor.user().profile.unanswered_questions[unansweredCount-1].text
        )
        notification.show()
        clearInterval(window.blinkInterval)
        window.blinkInterval = window.setInterval(->
          document.title = if document.title is 'PennApps'
            "#{unansweredCount} Unanswered Question#{if unansweredCount isnt 1 then 's' else ''}"
          else
            'PennApps'
        , 1500)
      )
)
