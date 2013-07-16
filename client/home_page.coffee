Template.homePage.helpers(
  notifications: -> Notifications.find({}, sort: created: -1).fetch()
  notificationCount: ->
    if Meteor.user() then Meteor.user().profile.unseen_num else 0
  notificationTime: ->
    date = moment(this.created)
    date.format('h:mm a')
)

