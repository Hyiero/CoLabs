
Meteor.publish 'allUsers', -> Meteor.users.find()

Meteor.publish 'allProjects', -> Projects.find()

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

Meteor.publish 'myProjects', -> Projects.find users: @userId?
  
Meteor.publish 'project', (id) -> Projects.find id

Meteor.publish 'allInvitations', -> Invitations.find()

Meteor.publish 'projectInvitations', (id) -> Invitations.find project:id

Meteor.publish 'userInvitations', -> Invitations.find user: @userId

Meteor.users.allow
  update: (userId) -> @userId?