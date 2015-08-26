Accounts.onEmailVerificationLink (token,done)->
  Session.set 'firstTimeUser', true

Accounts.onLogin ->
  user = Meteor.user()
  if Session.get 'firstTimeUser' is true and user?
    Session.set Constants.sessionLoggedInUserKey, user
    Session.set 'firstTimeUser', false
    Meteor.call 'updateName()', user._id, user.username
    ### TODO: REMOVE IF UNEEDED
    Modal.show 'checkEmailRegistrationLinkModal',
      title: 'Login Form'
      message: 'Please check your email to complete registration'
    ###
    Router.go '/profile/edit'
