Hackathons = new Meteor.Collection('hackathons');

Notifications = new Meteor.Collection('notifications');

Projects = new Meteor.Collection('projects');

Questions = new Meteor.Collection('questions');
//{asker: asker_user_id, question: 'question string', answer: 'answer text' | undefined, createdAt: unix_timestamp}