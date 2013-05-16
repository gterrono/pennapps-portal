Projects.allow(
  update: (userId, doc, fieldNames, modifier) ->
    user = Meteor.users.findOne(userId)
    _.contains(doc.contributors, user.emails[0].address) and
      _.without(fieldNames, 'name', 'description', 'location').length is 0
)

ensureLoggedIn = (user, message) ->
  unless user
    throw new Meteor.Error(401, "You must be logged in to #{message}")

ensureNoProjectForHackathon = (user, hackathon) ->
  if user.profile.projects[hackathon._id]
    throw new Meteor.Error(422, "You already have a project for this hackathon")

addProjectForHackathon = (user, hackathon, project_id) ->
  update_dict = {}
  update_dict["profile.projects.#{hackathon._id}"] = project_id
  Meteor.users.update(user, $set: update_dict)

Meteor.methods(
  createProject: (name, description, location) ->
    user = Meteor.user()
    ensureLoggedIn(user, "make a new project")
    unless name and description
      throw new Meteor.Error(422, "Please fill in all of the fields")
    hackathon = Hackathons.findOne(current: true)
    ensureNoProjectForHackathon(user, hackathon)
    project_id =
      Projects.insert(name: name, description: description, hackathon: hackathon._id, contributors: [user.emails[0].address], location: location)
    addProjectForHackathon(user, hackathon, project_id)

  requestToJoin: (project_id) ->
    user = Meteor.user()
    ensureLoggedIn(user, "request to join a project")
    hackathon = Hackathons.findOne(current: true)
    ensureNoProjectForHackathon(user, hackathon)
    unless Projects.findOne(_id: project_id)
      throw new Meteor.Error(422, "This project does not exist")
    Projects.update(project_id, $addToSet: contributors: user.emails[0].address)
    addProjectForHackathon(user, hackathon, project_id)
    
)
