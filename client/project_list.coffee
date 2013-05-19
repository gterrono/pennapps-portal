Template.projectList.helpers(
  projects: -> Projects.find({}, sort: name: 1).fetch()
  userHasNoProject: ->
    Meteor.user() and not Meteor.user().profile.projects[Hackathons.findOne()._id]
)

Template.projectList.events(
  'click #new-project-button': (e) ->
    e.preventDefault()
    $('#projectModal').foundation('reveal', 'open')
)

Template.project.helpers(
  projectName: -> this.name
  contributors: -> this.contributors
  userHasNoProject: ->
    Meteor.user() and not Meteor.user().profile.projects[Hackathons.findOne()._id]
  self: -> this
)

Template.project.events(
  'click .request-to-join': (e) ->
    e.preventDefault()
    Meteor.call('requestToJoin', this._id)
)
