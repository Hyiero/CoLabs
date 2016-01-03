Template.powerGrant.onCreated ->
  @subscribe 'allUsers'

Template.powerGrant.helpers
  grantButton: -> Render.buttonSave
    dataCommand: 'grant'
    class: 'powerButton'
    type: 'success'
    icon: 'thumbs-o-up'
    text: 'Grant Admin'
  revokeButton: -> Render.buttonDelete
    dataCommand: 'revoke'
    class: 'powerButton'
    icon: 'thumbs-o-down'
    text: 'Revoke Admin'

Template.powerGrant.events
  'click .powerButton': (event) ->
    $elem = $ '#adminSelect'
    user = Meteor.users.findOne( username: $elem.val())
    if user?
      powerCommand =
        target: user._id
        command: $(event.currentTarget).data 'command'
      Meteor.call 'adminPower', powerCommand
    $elem.val ''

Template.adminList.onCreated ->
  @subscribe 'allUsers'

Template.adminList.helpers
  admins: -> (user for user in Meteor.users.find().fetch() when user.isAdmin)
