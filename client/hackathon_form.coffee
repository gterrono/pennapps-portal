Template.hackathonForm.helpers(
  isAdmin: -> Meteor.user() && Meteor.user().profile.admin
  hackathon: -> Hackathons.findOne()
  name: -> this.name
  seatingOptions: -> this.seatingOptions.join(', ') if this.seatingOptions
  prizes: -> _.pairs(this.prizes)
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
    prizes = {}
    for element in $('.prize')
      prizeName = $(element).find('.prize-name').val().trim()
      prizes[prizeName] = $(element).find('.prize-description').val() if prizeName
    Hackathons.update(this._id, $set: {name: name, seatingOptions: seatingOptions, prizes: prizes})

  'click #add-prize': (e) ->
    e.preventDefault()
    $('#prizes').append(Meteor.render(Template.prizeFields))

  'click': (e) -> e.stopPropagation()
)

Template.prizeFields.helpers(
  name: -> this[0]
  description: -> this[1]
)
