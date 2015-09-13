Template.profile.helpers

  firstEmail: ->
    email = this.emails[0]
    if email then email.address else ''
    
  isVerifiedUser:-> CoLabs.isVerifiedUser Meteor.userId()
  hasEmailSaved:-> this.emails[0]?

Template.profile.events
  'click #sendNotificationButton': (e) ->
    SendOneNotification("TypeB","Today","Juan")
  'click .resend': (event) ->
    if this.emails[0]
      Meteor.call 'sendVerificationEmail', Meteor.user()._id, (err) ->
        if not err
          toast.success 'Verificiation Email Sent',
            'Go check your email address!'