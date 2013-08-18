Template.notifications.helpers(
  notifications: -> Notifications.find({}, sort: created: -1).fetch()
  notificationCount: ->
    if Meteor.user() then Meteor.user().profile.unseen_num else 0
)

Template.notifications.events(
  'click #notifications-button': (e) ->
    e.preventDefault()
    unless window.sawNotifications
      e.stopPropagation()
      clearInterval(window.blinkInterval)
      document.title = 'PennApps'
      $('#notifications').addClass('dropdown-display')
      window.sawNotifications = true

  'click #notifications': (e) -> e.stopPropagation()
)


Template.notification.helpers(
  notificationText: -> this.text
  notificationTime: ->
    date = moment(this.created)
    date.format('h:mm a')
  unseenClass: ->
    if _.has(Meteor.user().profile.unseen, this._id) then 'unseen' else ''
)
