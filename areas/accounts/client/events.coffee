Accounts.onEmailVerificationLink (token,done)->
  Session.set 'firstTimeUser', true

Accounts.onLogin ->
  user = Meteor.user()
  if Session.get 'firstTimeUser' is true and user?
    Session.set Constants.sessionLoggedInUserKey, user
    Session.set 'firstTimeUser', false
    Meteor.call 'updateName()', user._id, user.username   
    Router.go '/profile/edit'
