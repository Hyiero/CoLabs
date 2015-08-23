Template.profileLanding.helpers(
  firstEmail: ->
    this.emails[0].address
)

Template.profileLanding.events(
  'click #sendNotificationButton':(e)->
    SendOneNotification("TypeB","Today","Juan")
)