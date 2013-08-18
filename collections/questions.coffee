Meteor.methods(
	createQuestion: (text) -> 
		if not Meteor.user()?
			throw new Meteor.Error(401, "You need to be logged in to ask a question.")
		questionId = Questions.insert
			asker: Meteor.user().profile.name || Meteor.user().emails[0].address
			question: text 
			answer: undefined
			createdAt: moment().unix() 
		if Meteor.isServer
			admins = Meteor.users.find({'profile.admin': true}).fetch()
			for admin in admins
				unanswered_questions = _.clone(admin.profile.unanswered_questions)
				unanswered_num = admin.profile.unanswered_num
				unanswered_questions.push( {text: text, id: questionId} ) #need both text of question and its id on startup since the collection isn't initialized
				unanswered_num += 1
				Meteor.users.update({_id: admin._id}, {$set: {"profile.unanswered_questions": unanswered_questions, "profile.unanswered_num":unanswered_num}})
	updateQuestion: (questionId, text) -> 
		question = Questions.findOne({_id: questionId})
		if question.asker isnt Meteor.userId() and not Meteor.user().profile.admin
			throw new Meteor.Error(403, "You did not create this question, so you cannot edit it.")
		if question.answer?
			throw new Meteor.Error(403, "You cannot modify a question once it has been answered. Just ask another one.")
		Questions.update({_id: questionId}, {$set: {question: text}})
		if Meteor.isServer
			admins = Meteor.users.find({'profile.admin': true}).fetch()
			for admin in admins
				unanswered_questions = _.clone(admin.profile.unanswered_questions)
				unanswered_questions = _.map(unanswered_questions, (obj)->
					if(obj.id is questionId)
						obj.text = text
					return obj
				)
				Meteor.users.update({_id: admin._id}, {$set: {"profile.unanswered_questions": unanswered_questions}})
	deleteQuestion: (questionId) ->
		question = Questions.findOne({_id: questionId})
		unless question?
			throw new Meteor.Error(404, 'Question with that ID not found')
		if question.asker isnt Meteor.userId()
			throw new Meteor.Error(403, "You can't delete a question that isn't yours.")
		Questions.remove(questionId)
		if Meteor.isServer
			admins = Meteor.users.find({"profile.admin": true}).fetch()
			for admin in admins
				unanswered_questions = _.chain(admin.profile.unanswered_questions).clone().reject((obj)->
					return obj.id is questionId
				).value()
				unanswered_num = admin.profile.unanswered_num - 1;
				Meteor.users.update(admin._id, {$set: {"profile.unanswered_questions": unanswered_questions, "profile.unanswered_num": unanswered_num}})
				
)