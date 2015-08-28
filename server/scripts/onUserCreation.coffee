#Sends out email and then logs the person in. We should think about not allowing the user to log in
#until the email verification link has been clicked

Accounts.onCreateUser (options, user) ->
  user.profile ?= {}
  user.projects ?= []
  user.notifications ?= {}
  user.avatar ?= ""
  user.age ?= ""
  user.tags ?= ["searchable", "user"]
  user.contacts = []
  user.emails ?= []
  user.firstName ?= ""
  user.name ?= user.username
  
  Logger.enable()
  console.info user
  
  #TODO: Better, more predictable solution?
  Meteor.setTimeout (->
    Accounts.sendVerificationEmail user._id unless !user.emails.length
    ), 5000
  user