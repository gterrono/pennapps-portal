Template.notifications.helpers(
  notifications: -> Notifications.find().fetch()
  notificationCount: ->
    if Meteor.user() then Meteor.user().profile.unseen_num else 0
)

Template.notifications.events(
  'click #notifications-button': (e) ->
    e.preventDefault()
    e.stopPropagation()
    $('#notifications').addClass('dropdown-display')

  'click #notifications': (e) -> e.stopPropagation()
)
