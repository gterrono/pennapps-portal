Meteor.publish('currentHackathon', ->
  Hackathons.find({current: true}, fields: created: false)
)

Meteor.publish('mentors', -> Meteor.users.find('profile.mentor': true))

Meteor.publish('notifications', -> Notifications.find(for: $exists: false))

Meteor.publish('myNotifications', -> Notifications.find(for: $all: [this.userId]))

Meteor.publish('projects', -> Projects.find())

Meteor.publish('queue', ->
  user = Meteor.users.findOne _id: this.userId

  if user?.profile?.queue
    users = (el[0] for el in user.profile.queue)
    Meteor.users.find(_id: $in: users)
)

Meteor.publish('questions', -> Questions.find())