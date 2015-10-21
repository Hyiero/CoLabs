Template._justVerifiedEmailDialog.visiblle = -> false
Template._justVerifiedEmailDialog.created = ->
  $('.modal-backdrop.in').remove()
  Accounts._loginButtonsSession.set('justVerifiedEmail', false)

Template.splash.created = ->
  if Accounts._verifyEmailToken and not CoLabs.isVerifiedUser()
    Accounts.verifyEmail Accounts._verifyEmailToken, (err, res) ->
      if err? console.error err.message
      else
        console.info 'you are verified', res:res
        toast.success "You Are Verified!",
          "You now have the ability to create or participate in projects.
          Go to your profile page to add one, or search for one to request an invite.
          Have a happy collaboration!",
          20000
            
Template.splash.events
  "click .searchChoice": (event) ->
    type = $(event.target).attr("value") or
      $(event.target).parent().attr("value")
    Session.set "typeSearch", type
    Session.set "tagSearch", ""
    Session.set "nameSearch", ""
    Router.go "search", type: type