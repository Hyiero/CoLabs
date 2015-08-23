Meteor.publish('allUsers',()->
  Meteor.users.find()
)

Meteor.users.allow({
  update:(userId)->
    return !!userId;
})



