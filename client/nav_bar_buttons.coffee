Template.navBarButtons.events(
  'click #sign-in': (e) ->
    e.preventDefault()

    $('#sign-in-modal').foundation('reveal', 'open')
)
