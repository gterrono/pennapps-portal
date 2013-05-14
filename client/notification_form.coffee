Template.notificationForm.helpers(
  isAdmin: -> Meteor.user() && Meteor.user().profile.admin
)

Template.notificationForm.events(
  'click .close-reveal-modal': (e) ->
    e.preventDefault()
    $('#newNotificationModal').foundation('reveal', 'close')

  'click': (e) -> e.stopPropagation()
)
