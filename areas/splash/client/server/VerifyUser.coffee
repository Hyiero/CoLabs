#Script for verifying the user email address
Template.splashLanding.created = ->
  if Accounts._verifyEmailToken
    Accounts.verifyEmail Accounts._verifyEmailToken, (err) ->
      if err?
        err.message
      else
        console.log "Congratz you are now confirmed"
