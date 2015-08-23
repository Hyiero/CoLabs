@Users = {}

Users.findOne = (name)->
  Meteor.users.findOne({name:name})

Users.findByUsername = (username)->
  Meteor.users.findOne({username:username})

Users.find = ->
  Meteor.users.find()
