@CoLabs = {}
CoLabs.methodNames = []
CoLabs.methods = (obj) ->
  Meteor.methods obj
  ###
  that = this
  wrapFn = (fn) -> (args...) ->
    try
      return fn.apply that args...
    catch err
      wasDisabled = not Logger.isEnabled
      Logger.enable()
      console.error err
      if wasDisabled then Logger.disable()
      throw err
      
  for name,fn of obj
    CoLabs.methodNames.push name
    method = {}
    method[name] = wrapFn fn
    Meteor.methods method
  ###

CoLabs.methods
  updateUser: (obj) ->
    console.info "thisuserId":this.userId
    id = this.userId
    user = Meteor.users.findOne _id:id
    emails = if obj.email isnt "" then [address: obj.email, verified: false] else false
    
    # Check if already verified
    for email in user.emails.filter((e) -> e.verified)
      if obj.email is email.address then emails[0].verified = true
    
    result = Meteor.users.update { _id: id }, $set:
      emails: emails or user.emails
      avatar: obj.avatar or obj.identiconHex
      firstName: obj.firstName
      lastName: obj.lastName
      description: obj.description
      age: obj.age
      tags: obj.tags
      identiconHex: obj.identiconHex
    !result? or false

  updateName: (id,newName) ->
    Meteor.users.update _id: id,
      $set: { name: newName }
    
  sendVerificationEmail: (userId) ->
    #Logger.enable()
    console.info userId
    if Meteor.isServer then Accounts.sendVerificationEmail userId