
Meteor.publish('allUsers', ->
  Meteor.users.find()
)

Meteor.publish('allProjects', ->
  Projects.find()
)
Meteor.publish('allMessages', ()->
  Messages.find()
)
Meteor.publish('myProjects', (userId) ->
  if Helpers.isVerifiedUser() and userId
    Projects.find(
      users: { $in: userId }
    )
  else console.warn 'User is not verified.'
)

Meteor.users.allow
  update: (userId) -> userId?