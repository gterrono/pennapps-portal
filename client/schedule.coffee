Template.schedule.helpers(
	eventList: -> 
		Schedule.find({}, sort: {time: 1, _id: 1})
)

Template.event.helpers(
	readable_time: -> 
		return moment.unix(this.time).format('ddd, M/D @ h:mA').replace('@', 'at')
)