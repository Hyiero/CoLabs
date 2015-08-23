Meteor.publish('allUsers',()->
  Meteor.users.find()
)
Meteor.publish('allProjects', ()->
  Projects.find()
)
Meteor.users.allow({
  update:(userId)->
    return !!userId;
})

