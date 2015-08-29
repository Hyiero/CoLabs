Template.profileLanding.helpers

  firstEmail: ->
    email = this.emails[0]
    if email then email.address else ''
    
  isVerifiedUser:-> Helpers.isVerifiedUser Meteor.userId()
  hasEmailSaved:-> this.emails[0]?

Template.profileLanding.events
  'click #sendNotificationButton': (e) ->
    SendOneNotification("TypeB","Today","Juan")
  'click .resend': (event) ->
    if this.emails[0]
      Meteor.call 'sendVerificationEmail', Meteor.user()._id