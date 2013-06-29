Meteor.users.allow(
  update: (userId, doc, fieldNames, modifier) ->
    fieldName = fieldNames[0]
    fieldName.indexOf('profile.prizes.') is 0 and fieldNames.length is 1 and userId is doc._id
)

Meteor.users.allow
  update: (userId, doc, fieldNames, modifier) ->
    fieldNames.length == 1 and modifier['$addToSet'] and modifier['$addToSet']['profile.queue']

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
            queue: []
        Accounts.sendEnrollmentEmail Meteor.users.findOne('emails.address': email)._id

  joinQueue: (id) ->
    now = new Date().getTime()
    Meteor.users.update id,
      $push:
        'profile.queue': [Meteor.user()._id, now]
    mentor = Meteor.users.findOne _id: id
    unseen = _.clone mentor.profile.unseen
    unseen_num = Meteor.user().profile.unseen_num
    unseen[id] = true
    unseen_num += 1
    Meteor.users.update id,
      $set:
        "profile.unseen": unseen
        "profile.unseen_num": unseen_num
    Notifications.insert
      created: new Date().getTime()
      text: "#{Meteor.user().emails[0].address} joined your queue"
      action: "/queue"
      for: [id]
)
