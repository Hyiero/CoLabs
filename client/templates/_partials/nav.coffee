Template.loginButton.events
  'click': ->
    authService = this.toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Session.set Constants.sessionLoggedInUserKey,"Juan"
    console.log(Session.get Constants.sessionLoggedInUserKey)
    Meteor["loginWith#{authService}"]()


Accounts.onLogin(->
  Session.set Constants.sessionLoggedInUserKey,"Juan"
  console.log("User name set")
)
