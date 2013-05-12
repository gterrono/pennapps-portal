Meteor.publish('currentHackathon', ->
  return Hackathons.find({current: true}, fields: {created: false})
)
