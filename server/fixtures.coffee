if(Hackathons.find().count() is 0)
  now = new Date().getTime()

  Hackathons.insert(
    name: 'PennApps Fall 2013'
    code: '2013f'
    created: now
    current: true
  )

if(Meteor.users.find().fetch().length is 0)
  Accounts.createUser(
    email: 'exec@pennapps.com'
    password: 'iampennappsexec'
    profile:
      admin: true
      name: 'PennApps Exec'
      unseen: {}
      unseen_num: 0
      projects: {}
      prizes: {}
      unanswered_questions: []
  )
