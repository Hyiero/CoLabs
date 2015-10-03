CoLabs.methods
  removeUser: ->
    userId = Meteor.userId()
    Meteor.users.remove userId
    Notifications.remove sender:userId