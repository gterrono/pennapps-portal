Template.notifications.helpers(
  notifications: -> Notifications.find().fetch()
  notificationCount: ->
    if Meteor.user() then Meteor.user().profile.unseen_num else 0
)
