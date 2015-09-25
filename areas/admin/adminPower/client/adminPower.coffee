Template.powerGrant.events
  "click .powerButton": (event)->
    user = Meteor.users.findOne( username: $("#adminSelect").val() )
    if user?
      powerCommand =
        target: user._id
        command: $(event.currentTarget).data "command"
      Meteor.call "adminPower", powerCommand

Template.adminList.helpers
  admins: ()-> (user for user in Meteor.users.find().fetch() when user.isAdmin?)