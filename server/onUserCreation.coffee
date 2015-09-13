#Sends out email and then logs the person in. We should think about not allowing the user to log in
#until the email verification link has been clicked

Accounts.onCreateUser (options, user) ->
  user.profile ?= {}
  user.projects ?= []
  user.notifications ?= {}
  user.avatar ?= ""
  user.age ?= ""
  user.tags ?= []
  user.type ?= "user"
  user.contacts ?= []
  user.emails ?= []
  user.firstName ?= ""
  user.name ?= user.username
  
  #Logger.enable()
  #console.info user
  
  Logger.enable()
  
  last = null
  checkIfReady = ->
    last = Meteor.setTimeout (->
      if user.emails.length > 0
        console.info "Sending verification email."
        Accounts.sendVerificationEmail user._id
      else
        console.info "Checking if ready for verification email"
        checkIfReady()
    ), 1000
  
  Meteor.setTimeout checkIfReady, 1000
  Meteor.setTimeout (-> clearTimeout last), 10000
  
  user