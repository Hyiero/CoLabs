Template.powerGrant.events
  "click .powerButton": (event)->
    console.log "click"
    user = Meteor.users.findOne( username: $("#adminSelect").val() )
    if user?
      powerCommand =
        target: user._id
        command: $(event.currentTarget).data "command"
      console.log powerCommand
      Meteor.call "adminPower", powerCommand

Template.adminList.helpers
  admins: ()-> (user for user in Meteor.users.find().fetch() when user.isAdmin?)