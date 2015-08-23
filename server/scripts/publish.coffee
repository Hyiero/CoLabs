Meteor.publish('allUsers',()->
  Meteor.users.find()
)
Meteor.publish('allProjects', ()->
  Projects.find()
)
