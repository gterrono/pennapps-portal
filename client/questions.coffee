Template.questionList.helpers(
	questions: -> Questions.find({answered: undefined}).fetch()
)

Template.question.helpers(
	answered: -> @answered?
	asker_name: -> Users.findOne(@asker)
	isAdmin: -> Meteor.User().profile.admin
)