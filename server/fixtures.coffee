if(Hackathons.find().count() is 0)
  now = new Date().getTime()

  Hackathons.insert(
    name: 'PennApps Fall 2013'
    code: '2013f'
    created: now
    current: true
  )
