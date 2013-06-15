Meteor.publish('currentHackathon', ->
  Hackathons.find({current: true}, fields: created: false)
)

Meteor.publish('mentors', -> Meteor.users.find('profile.mentor': true))

Meteor.publish('notifications', -> Notifications.find({}, sort: created: -1))

Meteor.publish('projects', -> Projects.find())

Meteor.publish('queue', ->
  user = Meteor.users.findOne _id: this.userId

  if user.profile.queue
    Meteor.users.find(_id: $in: user.profile.queue)
)
