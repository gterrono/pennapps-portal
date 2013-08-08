Meteor.methods(
  addEvent: (name, timestamp, location, description, willNotify = false) ->
    console.log 'adding'
    if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to add schedule events.")
    time = moment(timestamp).format('ddd, M/D @ h:mA').replace('@', 'at')
    id = Schedule.insert(name: name, time: time, location: location, description: description)
    console.log id
    notif_text = "EVENT ADDED: #{name} is scheduled for #{time}, and will take place at #{location}. Be there, or be square!"
    if willNotify
      Meteor.call('notify', notif_text)
    return id
  removeEvent: (_id, notify = false) ->
  	if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to remove schedule events.")
    {name, time, location, description} = Schedule.findOne({_id: _id})
    Schedule.remove({_id: _id})
    notif_text = "EVENT CANCELLED: #{name} has been cancelled. DO NOT go to #{location} at #{time}."
  updateEvent: (_id, name, timestamp, location, description, notify = false) ->
    if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to update schedule events.")
    time = moment(timestamp).format('ddd, M/D @ h:mA').replace('@', 'at')
    # meteor supports literal updating
    id = Schedule.update({_id: _id}, {name: name, time: time, location: location, description: description})
    notif_text = "EVENT UPDATE: #{name} is now scheduled for #{time}, at location #{location}. Adjust accordingly!"
    if notify
      Meteor.call('notify', notif_text)
)