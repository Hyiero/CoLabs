Template.avatar.helpers
  size: -> this.size or 'sm'
  avatar: -> false
  identiconHex: ->
    if this.temp? then this.temp
    else (Meteor.users.findOne this.userId)?.identiconHex

Template.avatar.events
  "click": (e) ->
    username = Template.parentData()?.username
    if not username?
      username = ( Meteor.users.findOne this.userId )?.username
    if username? then Router.go "/#{username}/profile"
    else console.warn 'Could not find username, will not redirect.'