Template.hackathonForm.helpers(
  isAdmin: -> Meteor.user() && Meteor.user().profile.admin
  hackathon: -> Hackathons.findOne()
  name: -> this.name
  prizes: -> this.prizes.join(', ') if this.prizes
  seatingOptions: -> this.seatingOptions.join(', ') if this.seatingOptions
)

Template.hackathonForm.events(
  'click .close-reveal-modal': (e) ->
    e.preventDefault()
    $('#hackathonModal').foundation('reveal', 'close')

  'submit #hackathon-form': (e) ->
    e.preventDefault()
    $('#hackathonModal').foundation('reveal', 'close')
    name = $('#hackathon-name').val()
    seatingOptions = (s.trim() for s in $('#hackathon-seating-options').val().split(','))
    prizes = (p.trim() for p in $('#hackathon-prizes').val().split(','))
    Hackathons.update(this._id, $set: {name: name, seatingOptions: seatingOptions, prizes: prizes})

  'click': (e) -> e.stopPropagation()
)
