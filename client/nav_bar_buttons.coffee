Template.navBarButtons.helpers(
  isAdmin: -> Meteor.user() && Meteor.user().profile.admin
)

Template.navBarButtons.events(
  'click #new-notification-button': (e) ->
    e.preventDefault()
    $('#newNotificationModal').foundation('reveal', 'open')
)
