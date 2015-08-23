Template.profileLanding.helpers(
  firstEmail:(user)->
    user.emails[0].address
)

Template.profileLanding.events(
  'click #sendNotificationButton':(e)->
    SendOneNotification("TypeB","Today","Juan")
)