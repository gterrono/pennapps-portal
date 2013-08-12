Meteor.methods(
  addEvent: (name, timestamp, location, description, willNotify = false) ->
    if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to add schedule events.")
    id = Schedule.insert(name: name, time: timestamp, location: location, description: description)
    humanReadabletime = moment.unix(timestamp).format('ddd, M/D/YY @ h:mA').replace('@', 'at')
    notif_text = "EVENT ADDED: #{name} is scheduled for #{humanReadabletime}, and will take place at #{location}. Be there, or be square!"
    if willNotify
      Meteor.call('notify', notif_text)
    return id
  removeEvent: (_id, notify = false) ->
  	if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to remove schedule events.")
    {name, time, location, description} = Schedule.findOne({_id: _id})
    humanReadabletime = moment.unix(time).format('ddd, M/D/YY @ h:mA').replace('@', 'at')
    Schedule.remove({_id: _id})
    notif_text = "EVENT CANCELLED: #{name} has been cancelled. DO NOT go to #{location} at #{humanReadabletime}."
  updateEvent: (_id, name, timestamp, location, description, notify = false) ->
    if not (Meteor.user() and Meteor.user().profile.admin)
      throw new Meteor.Error(403, "You do not have permission to update schedule events.")
    humanReadabletime = moment(timestamp).format('ddd, M/D/YY @ h:mA').replace('@', 'at')
    # meteor supports literal updating
    id = Schedule.update({_id: _id}, {name: name, time: timestamp, location: location, description: description})
    notif_text = "EVENT UPDATE: #{name} is now scheduled for #{humanReadabletime}, at location #{location}. Adjust accordingly!"
    if notify
      Meteor.call('notify', notif_text)
)