Accounts.onEmailVerificationLink( (token,done)->
  Session.set("firstTimeUser",true)
)

Accounts.onLogin(()->
  if Session.get("firstTimeUser") is true
    console.log("On Login")
    Session.set("firstTimeUser",false)
    Meteor.call('updateName()',Meteor.user()._id,Meteor.user().username)
    Modal.show('checkEmailRegistrationLinkModal',{title:"Login Form",message:"Please check your email to complete registration"})
    Router.go("/profile/edit")
)