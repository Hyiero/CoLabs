Accounts.onLogin(->
  Session.set Constants.sessionLoggedInUserKey,Meteor.user.username
  console.log("User name set:"+Meteor.user.username)
)