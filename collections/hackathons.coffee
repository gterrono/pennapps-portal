Hackathons.allow(
  update: (userId, doc, fieldNames, modifier) ->
    user = Meteor.users.findOne(userId)
    user.profile.admin
)
