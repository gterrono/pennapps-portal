Meteor.publish('currentHackathon', ->
  Hackathons.find({current: true}, fields: {created: false})
)

Meteor.publish('notifications', -> Notifications.find({}, sort: {created: -1}))
