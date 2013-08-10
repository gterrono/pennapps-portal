Meteor.Router.add(
  '/': 'homePage'
  '/mentors': 'mentorList'
  '/projects': 'projectList'
  '/prizes': 'prizes'
  '/queue': 'mentorQueue'
  '/schedule': 'schedule'
  '*': '404'
)

Meteor.Router.filters
  'isMentor': (page) ->
    page if Meteor.user()?.profile.admin

Meteor.Router.filter 'isMentor', only: 'queue'
