Meteor.users.allow(
  update: (userId, doc, fieldNames, modifier) ->
    fieldName = fieldNames[0]
    fieldName.indexOf('profile.prizes.') is 0 and fieldNames.length is 1 and userId is doc._id
)

Meteor.methods(
  resetNotifications: ->
    Meteor.users.update(this.userId, {$set: {"profile.unseen": {}, "profile.unseen_num": 0}})

  createMentor: (email, name) ->
    if Meteor.isServer
      if Meteor.user()?.profile.admin
        Accounts.createUser
          email: email
          profile:
            mentor: true
            name: name
            unseen: {}
            unseen_num: 0
            projects: {}
            prizes: {}
        Accounts.sendEnrollmentEmail Meteor.users.findOne('emails.address': email)._id
)
