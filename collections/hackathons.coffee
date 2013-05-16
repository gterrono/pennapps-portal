Hackathons.allow(
  update: (userId, doc, fieldNames) ->
    user = Meteor.users.findOne(userId)
    user.profile.admin
)
