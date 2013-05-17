Meteor.users.allow(
  update: (userId, doc, fieldNames, modifier) ->
    fieldName = fieldNames[0]
    fieldName.indexOf('profile.prizes.') is 0 and fieldNames.length is 1 and userId is doc._id
)
