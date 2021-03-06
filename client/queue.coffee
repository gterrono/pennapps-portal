Template.mentorQueue.helpers(
  queue: ->
    idToTime = _.object(Meteor.user().profile.queue)
    Meteor.user().profile.queue
)

Template.queueItem.helpers(
  hacker: -> Meteor.users.findOne(_id: this[0].toString())
  hackerName: -> this.emails[0].address
  hackerLocation: -> Projects.findOne(contributors: this.emails[0].address).location
)

Template.queueItem.events(
  'click .dequeue': (e) ->
    e.preventDefault()
    idToTime = _.object(Meteor.user().profile.queue)
    Meteor.users.update Meteor.user()._id, $pull: 'profile.queue': [this._id, idToTime[this._id]]
)
