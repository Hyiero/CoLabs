Users= {}

Users.GetTestUser = ->
  Meteor.users.findOne({name:"Juan"})
  },
  {
    name: "Christopher"
    image: "johnny-liftoff.jpg"
    age: 37
    interests: ["users", "projects", "tags"]

Users.findOne = (name)->
  Meteor.users.findOne({name:name})

Users.find = ->
  Meteor.users.find()






