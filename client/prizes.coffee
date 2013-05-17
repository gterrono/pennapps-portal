Template.prizes.helpers(
  name: -> this[0]
  description: -> this[1]
  prizes: ->
    hackathon = Hackathons.findOne()
    _.pairs(hackathon.prizes)
)

Template.prizes.events(
  'click .prize-sign-up': (e) -> console.log 'signing up'
)
