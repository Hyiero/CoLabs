CoLabs.methods
  removeSelf: ->
    userId = Meteor.userId()
    Meteor.users.remove userId
    Notifications.remove userId: userId