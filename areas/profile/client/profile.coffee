Template.profile.helpers
  user: -> Meteor.user()
  resendEmailButton: -> Render.buttonImportant
    icon: 'share'
    text: 'Resend'
    dataContext: emails: @emails
    onclick: ->
      if @data('context')?.emails?.length > 0
        message = ['Verificiation Email Sent', 'Go check your email address!']
        Meteor.call 'sendVerificationEmail', Meteor.userId(), (err) ->
          unless err? then toast.success message...
  firstEmail: -> if @emails?.length > 0 then @emails[0].address else ''
  firstVerifiedEmail: ->
    if @emails?.length > 0
      email = (@emails?.filter (e) -> e.verified)[0]
      if email then email.address else ''
  isVerifiedUser: -> CoLabs.isVerifiedUser()
  hasEmailSaved: -> @emails?.length > 0
  hasVerifiedEmail: -> (@emails[0]?.filter (e) -> e.verified).length > 0
  interests: -> @tags?
