Template.profile.helpers
  resendEmailButton: -> Render.buttonImportant
    icon: 'share'
    text: 'Resend'
    onclick: -> if @emails?[0]?
      Meteor.call 'sendVerificationEmail',
        Meteor.user()._id, (err) -> if not err
          toast.success 'Verificiation Email Sent',
            'Go check your email address!'
  firstEmail: ->
    email = @emails[0]
    if email then email.address else ''
  firstVerifiedEmail: ->
    email = (@emails?.filter (e) -> e.verified)[0]
    if email then email.address else ''
  isVerifiedUser: -> CoLabs.isVerifiedUser Meteor.userId()
  hasEmailSaved: -> @emails?.length > 0
  hasVerifiedEmail: -> (@emails[0]?.filter (e) -> e.verified).length > 0
  interests: -> @tags?
