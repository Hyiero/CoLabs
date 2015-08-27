
Meteor.publish('allUsers', ->
  Meteor.users.find()
)

Meteor.publish('allProjects', ->
  Projects.find()
)
Meteor.publish('allMessages', ()->
  Messages.find()
)

Meteor.publish('thisUser', (id) ->
  Meteor.users.find({_id:id})
)
Meteor.publish('myProjects', (id) ->
  if id and Helpers.isVerifiedUser(id)
    Projects.find(
      users: id #this matches when users is an array that contains id, which is what we want
    )
  else 
    console.warn 'User is not verified.'
    []    
)

Meteor.users.allow
  update: (userId) -> this.userId?