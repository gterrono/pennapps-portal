Template.questions.helpers(
	questions: -> Questions.find({answered: undefined}, {sort: createdAt: 1}).fetch()
)

Template.question.helpers(
	answered: -> @answered?
	asker_name: -> @asker
	isAdmin: -> Meteor.user().profile.admin
)