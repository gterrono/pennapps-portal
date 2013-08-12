webkitNotify = (title, text) -> 
	if window.webkitNotifications.checkPermission() is 0
      notification = window.webkitNotifications.createNotification '/icon.png', title, text
      notification.show()

Template.schedule.helpers(
	eventList: -> 
		Schedule.find({}, sort: {time: 1, _id: 1})
	userIsAdmin: -> 
		Meteor.user() and Meteor.user().profile.admin
)

Template.newEvent.rendered = ->
	$(@find '.time').appendDtpicker(dateFormat: 'M/D/YYYY h:mm', current: '8/6/2013 12:00', firstDayOfWeek: 1)

Template.newEvent.events
	'click .submit': (event, template) ->
		name = $(template.find '.name').val()
		timestamp = moment($(template.find '.time').val(), 'M/D/YYYY HH:mm').unix()
		location = $(template.find '.location').val()
		description = $(template.find '.description').val()
		willNotify = true
		Meteor.call('addEvent', name, timestamp, location, description, willNotify)
		#clear everything
		$(template.find '.name').val('')
		$(template.find '.location').val('')
		$(template.find '.description').val('')

Template.editableEvent.events
	'click .change': (event, template) ->
		name = $(template.find '.name').text()
		console.log $(template.find '.time').text().replace('at', '@')
		timestamp = moment($(template.find '.time').text().replace('at', '@'), 'ddd, M/D/YY @ h:mmA').unix()
		location = $(template.find '.location').text()
		description = $(template.find '.description').text()
		willNotify = true
		Meteor.call('updateEvent', @_id, name, timestamp, location, description, willNotify)
		webkitNotify('Update Successful!', "#{@_id} updated successfully!")

	'click .delete': (event, template) ->
		userSure = window.confirm("Do you really want to delete this event?")
		willNotify = true
		if userSure
			Meteor.call('removeEvent', @_id, willNotify)
			webkitNotify('Removal Successful!', "#{@_id} removed successfully!")


		

Template.event.helpers(
	readable_time: -> 
		return moment.unix(this.time).format('ddd, M/D/YY @ h:mmA').replace('@', 'at')
)

Template.editableEvent.helpers(
	readable_time: -> 
		return moment.unix(this.time).format('ddd, M/D/YY @ h:mmA').replace('@', 'at')
)