Meteor.publish('userLoggedIn',()->
  Meteor.users.find({_id: this.userId})
)
Meteor.publish('allProjects', ()->
  Projects.find()
)
Meteor.users.allow({
  update:(userId)->
    return !!userId;
})

