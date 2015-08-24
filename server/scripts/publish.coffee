
Meteor.publish('allUsers', ->
  Meteor.users.find()
)

Meteor.publish('allProjects', ->
  Projects.find()
)
Meteor.publish('allMessages', ()->
  Messages.find()
)
Meteor.publish('myProjects', (id) ->
  if id and Helpers.isVerifiedUser(id)
    Projects.find(
      users: { $in: id }
    )
  else console.warn 'User is not verified.'
)

Meteor.users.allow
  update: (userId) -> this.userId?