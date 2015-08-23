Meteor.publish('userLoggedIn',()->
  Meteor.users.find({_id: this.userId})
)
Meteor.publish('allProjects', ()->
  Projects.find()
)
Meteor.publish('myProjects', (userId) ->
  if Helpers.isVerifiedUser()
    Projects.find(
      users: { $in: userId }
    )
  else console.warn 'User is not verified.'
)
Meteor.users.allow({
  update:(userId)->
    return !!userId;
})

