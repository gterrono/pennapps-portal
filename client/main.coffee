Meteor.subscribe 'currentHackathon'

Meteor.subscribe 'notifications'

$( ->
  $('body').click((e) ->
    $('#notifications').removeClass('dropdown-display')
  )
)
