Template.mentorList.helpers(
  mentors: -> Meteor.users.find('profile.mentor': true).fetch()
)

Template.mentor.helpers(
  mentorName: -> this.profile.name
  mentorDescription: -> this.profile.description
  queueLength: -> this.profile.queue.length
  inQueue: -> _.contains this.profile.queue, Meteor.user()._id
)

Template.mentor.events(
  'click .join-queue': (e) ->
    e.preventDefault()
    Meteor.users.update this._id, $addToSet: 'profile.queue': Meteor.user()._id
)
