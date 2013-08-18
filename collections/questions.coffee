Meteor.methods(
	createQuestion: (text) -> 
		if not Meteor.user()?
			throw new Meteor.Error(401, "You need to be logged in to ask a question.")
		questionId = Questions.insert asker: Meteor.user()._id, question: text, answer: undefined, createdAt: moment().unix() 
		admins = Meteor.users.find({'profile.admin': true}).fetch()
		for admin in admins
			unanswered_questions = _.clone(admin.profile.unanswered_questions)
			unanswered_questions.push questionId
			Meteor.users.update({_id: admin._id}, {$set: {"profile.unanswered_questions": unanswered_questions}})
		questionId
	updateQuestion: (questionId, text) -> 
		question = Questions.findOne({_id: questionid})
		if question.asker isnt Meteor.userId()
			throw new Meteor.Error(403, "You did not create this question, so you cannot edit it.")
		if question.answer?
			throw new Meteor.Error(403, "You cannot modify a question once it has been answered. Just ask another one.")
		Questions.update({_id: questionId}, {$set: {question: text}})
	deleteQuestion: (questionId) ->
		question = Questions.findOne({_id: questionId})
		if question.asker isnt Meteor.userId()
			throw new Meteor.Error(403, "You can't delete a question that isn't yours.")
		Questions.remove(questionId)
		admins = Meteor.users.find({"profile.admin": true}).fetch()
		for admin in admins
			unanswered_questions = _.chain(admin.profile.unanswered_questions).clone().reject((id) -> id is questionId).value()
			Meteor.users.update(admin._id, {$set: {"profile.unanswered_questions": unanswered_questions}})
)