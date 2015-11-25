Template.userAvatar.helpers
  size: -> @size or 'sm'
  avatar: -> false
  identiconHex: ->
    if @temp? then @temp
    else (Meteor.users.findOne @userId)?.identiconHex

Template.userAvatar.events
  'click': (e) ->
    username = Template.parentData()?.username
    unless username?
      username = ( Meteor.users.findOne @userId )?.username
    if username? then Router.go "/#{username}/profile"
    else console.warn 'Could not find username, will not redirect.'