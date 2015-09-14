Template.avatar.helpers
  avatar: -> false
  identiconHex: ->
    (Meteor.users.findOne this.userId)?.identiconHex