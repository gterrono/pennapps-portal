Meteor.methods(
  notify: (text) ->
    if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to make notifications.")
    now = new Date().getTime()
    id = Notifications.insert(created: now, text: text)
    for user in Meteor.users.find().fetch()
      unseen = _.clone(user.profile.unseen)
      unseen_num = user.profile.unseen_num
      unseen[id] = true
      unseen_num += 1
      console.log unseen
      Meteor.users.update(user, {$set: {"profile.unseen": unseen, "profile.unseen_num": unseen_num}})
      console.log Meteor.users.findOne({_id: user._id}).profile
)
