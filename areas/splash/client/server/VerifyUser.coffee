#Script for verifying the user email address
Template.splashLanding.created = ->
  if Accounts._verifyEmailToken
    Accounts.verifyEmail Accounts._verifyEmailToken, (err) ->
      if err? console.error err.message
      else
        Modal.show 'checkEmailRegistrationLinkModal',
          title: 'You Are Verified!'
          message: "You now have the ability to create or participate in projects.
            Go to your profile page to add one, or search for one to request an invite!
            Have a happy collaboration!"