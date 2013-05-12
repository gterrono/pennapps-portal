Handlebars.registerHelper 'hackathonName', ->
  hackathon = Hackathons.findOne(current: true)
  hackathon.name if hackathon

Handlebars.registerHelper 'ready', ->
  !! Hackathons.findOne()
