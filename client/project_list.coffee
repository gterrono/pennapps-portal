Template.projectList.helpers(
  projects: -> Projects.find().fetch()
)

Template.projectList.events(
  'click #new-project-button': (e) ->
    e.preventDefault()
    $('#newProjectModal').foundation('reveal', 'open')
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
