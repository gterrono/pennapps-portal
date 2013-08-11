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
		console.log name, timestamp, location, description
		Meteor.call('addEvent', name, timestamp, location, description)
		#clear everything
		$(template.find '.name').val('')
		$(template.find '.location').val('')
		$(template.find '.description').val('')

Template.event.helpers(
	readable_time: -> 
		return moment.unix(this.time).format('ddd, M/D @ h:mmA').replace('@', 'at')
	userIsAdmin: -> 
		Meteor.user() and Meteor.user().profile.admin
)
