Template.navBarButtons.helpers(
  isAdmin: -> Meteor.user() && Meteor.user().profile.admin
  userHasProject: ->
    user = Meteor.user()
    hackathonId = Hackathons.findOne()._id
    user and user.profile.projects[hackathonId]
)

Template.navBarButtons.events(
  'click #new-notification-button': (e) ->
    e.preventDefault()
    $('#newNotificationModal').foundation('reveal', 'open')

  'click #hackathon-button': (e) ->
    e.preventDefault()
    $('#hackathonModal').foundation('reveal', 'open')

  'click #project-edit-button': (e) ->
    e.preventDefault()
    $('#projectModal').foundation('reveal', 'open')
)
