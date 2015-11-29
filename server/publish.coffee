
Meteor.publish 'allUsers', -> Meteor.users.find()

Meteor.publish 'projectUsers', (id) ->
  project = Projects.findOne id
  users = project.users
  Meteor.users.find _id: $in: users

Meteor.publish 'conversationUsers', ->
  user = Meteor.users.findOne @userId
  contacts = (conversation.contact for conversation in user.conversations)
  Meteor.users.find _id: $in: contacts

Meteor.publish 'oneUser', (id) -> Meteor.users.find id

Meteor.publish 'oneUserByName', (username) -> Meteor.users.find username: username

Meteor.publish 'thisUser', -> Meteor.users.find @userId


Meteor.publish 'allProjects', -> Projects.find()

Meteor.publish 'oneProject', (id) -> Projects.find id

Meteor.publish 'myProjects', -> Projects.find users: @userId


Meteor.publish 'myMessages', ->
  Messages.find $or: [
    { to: @userId }
    { from: @userId }
  ]

Meteor.publish 'messagesWith', (contact)->
  Messages.find $or: [
    { to: @userId, from: contact }
    { to: contact, from: @userId }
  ]

Meteor.publish 'newMessageCount', ->
  Counts.publish @, 'newMessages', Messages.find(to: @userId, read: false)
  return undefined


Meteor.publish 'myNotifications', -> Notifications.find userId: @userId

Meteor.publish 'projectNotifications', (id) -> Notifications.find projectId: id


Meteor.users.allow
  update: (userId) -> @userId?