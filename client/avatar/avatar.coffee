Template.avatar.helpers
  size: -> this.size or 'sm'
  avatar: -> false
  identiconHex: ->
    if this.temp? then this.temp
    else (Meteor.users.findOne this.userId)?.identiconHex