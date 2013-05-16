Template.projectList.helpers(
  projects: -> Projects.find().fetch()
)

Template.projectList.events(
  'click #new-project-button': (e) ->
    e.preventDefault()
    $('#newProjectModal').foundation('reveal', 'open')

  'submit #project-form': (e) ->
    e.preventDefault()
    name = $('#project-name').val()
    description = $('#project-description').val()
    Project.insert(name: name, description: description)
    $('#newProjectModal').foundation('reveal', 'close')

  'click .close-reveal-modal': (e) ->
    e.preventDefault()
    $('#newProjectModal').foundation('reveal', 'close')

  'click': (e) -> e.stopPropagation()
)

Template.project.helpers(
  projectName: -> this.name
  contributors: -> this.contributors
)

Template.contributor.helpers(
  email: -> this
)
