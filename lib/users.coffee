@Users = {}

Users.findOne = (name)->
  Meteor.users.findOne({name:name})

Users.find = ->
  Meteor.users.find()
