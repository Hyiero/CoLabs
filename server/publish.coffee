
Meteor.publish 'allUsers', -> Meteor.users.find()

Meteor.publish 'projectUsers', (id) ->
  project = Projects.findOne id
  Meteor.users.find _id: $in: project.users

Meteor.publish 'projectAdmins', (id) ->
  project = Projects.findOne id
  Meteor.users.find _id: $in: project.admins

Meteor.publish 'oneUser', (id) -> Meteor.users.find id

Meteor.publish 'oneUserByName', (username) -> Meteor.users.find username: username

Meteor.publish 'thisUser', -> Meteor.users.find @userId


Meteor.publish 'allProjects', -> Projects.find()

Meteor.publish 'oneProject', (id) -> Projects.find id

Meteor.publish 'myProjects', ->
  user = Meteor.users.findOne @userId
  Projects.find _id: $in: user.projects


Meteor.publish 'oneMessage', (id)-> Messages.find id

Meteor.publish 'messagesWith', (contact)->
  Messages.find $or: [
    { to: @userId, from: contact }
    { to: contact, from: @userId }
  ]

Meteor.publish 'newMessageCount', ->
  Counts.publish @, 'newMessages', Messages.find(to: @userId, read: false)
  return undefined


Meteor.publish 'myNotifications', -> Notifications.find userId: @userId

Meteor.publish 'userInvites', (id) ->
  Notifications.find
    userId: id
    type: 'invite'

Meteor.publish 'projectNotifications', (id) -> Notifications.find 'data.projectId': id

Meteor.publish 'newNotificationCount', ->
  Counts.publish @, 'newNotifications', Notifications.find
    userId: @userId
    'data.status': 'none'
  return undefined


Meteor.users.allow
  update: (userId) -> @userId?