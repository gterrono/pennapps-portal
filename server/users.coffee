Accounts.onCreateUser((options, user) ->
  user.profile = if options.profile then options.profile else {}
  unseen = {}
  notifications = Notifications.find().fetch()
  for notification in notifications
    unseen[notification._id] = true
  user.profile.unseen = unseen
  user.profile.unseen_num = notifications.length
  user.profile.projects = {}
  user.profile.prizes = {}
  user
)
