Template.projectForm.events(
  'submit #project-form': (e) ->
    e.preventDefault()
    name = $('#project-name').val()
    description = $('#project-description').val()
    Meteor.call('createProject', name, description)
    $('#newProjectModal').foundation('reveal', 'close')
    $('#project-name').val('')
    $('#project-description').val('')

  'click .close-reveal-modal': (e) ->
    e.preventDefault()
    $('#newProjectModal').foundation('reveal', 'close')

  'click': (e) -> e.stopPropagation()
)
