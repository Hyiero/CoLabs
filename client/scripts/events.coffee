Accounts.onEmailVerificationLink( (token,done)->
  Session.set("firstTimeUser",true)
)

Accounts.onLogin(()->
  if Session.get("firstTimeUser") is true
    console.log("FirstTImeUser")
    Session.set("firstTimeUser",false)
    Router.go("/profile/edit")

)