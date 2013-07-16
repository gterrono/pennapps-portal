Template.notificationForm.helpers(
  isAdmin: -> Meteor.user() && Meteor.user().profile.admin
)

Template.notificationForm.events(
  'click .close-reveal-modal': (e) ->
    e.preventDefault()
    $('#newNotificationModal').foundation('reveal', 'close')

  'submit #notification-form': (e) ->
    e.preventDefault()
    Meteor.call('notify', $('#notification-text').val())
    $('#newNotificationModal').foundation('reveal', 'close')
)
