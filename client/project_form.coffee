Template.projectForm.helpers(
  name: -> this.name
  description: -> this.description
  location: -> this.location
  seatingOptions: ->
    options = Hackathons.findOne().seatingOptions
    if this.location
      _.without(options, this.location)
    else options
  edit: -> this._id
  usersProject: ->
    user = Meteor.user()
    hackathonId = Hackathons.findOne()._id
    currentProject = user.profile.projects[hackathonId] if user
    if currentProject
      Projects.findOne(currentProject)
    else
      {}
)

Template.projectForm.events(
  'submit #project-form': (e) ->
    e.preventDefault()
    name = $('#project-name').val()
    description = $('#project-description').val()
    location = $('#project-location').val()
    if this._id
      Projects.update(this._id, $set: {name: name, description: description, location: location})
    else
      Meteor.call('createProject', name, description, location)
    $('#projectModal').foundation('reveal', 'close')

  'click .close-reveal-modal': (e) ->
    e.preventDefault()
    $('#projectModal').foundation('reveal', 'close')

  'click': (e) -> e.stopPropagation()
)
