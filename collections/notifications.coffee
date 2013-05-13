Notifications.allow(
  insert: (userId, doc) ->
    now = new Date().getTime()
    doc.created = now
    Meteor.users.findOne(userId).profile.admin
)
