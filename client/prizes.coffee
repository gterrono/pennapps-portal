Template.prizes.helpers(
  name: -> this[0]
  description: -> this[1]
  prizes: ->
    hackathon = Hackathons.findOne()
    _.pairs(hackathon.prizes)
  userNotSignedUp: ->
    hackathon = Hackathons.findOne()
    not _.contains(Meteor.user().profile.prizes[hackathon._id], this[0])
)

Template.prizes.events(
  'click .prize-sign-up': (e) ->
    nameTag = $($(e.toElement).parent().get(0)).siblings()[0]
    console.log nameTag
    name = $(nameTag).text()
    hackathon = Hackathons.findOne()
    key = "profile.prizes.#{hackathon._id}"
    o = {}
    o[key] = name
    Meteor.users.update(Meteor.user()._id, $addToSet: o)
)
