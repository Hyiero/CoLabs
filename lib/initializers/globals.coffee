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
    email = user?.emails[0]
    
    console.log email:email
    if not email or email.address isnt obj.email
      emails = [address: obj.email or null, verified: false]
    
    result = Meteor.users.update { _id: id }, $set:
      emails: emails or user.emails
      avatar: obj.avatar
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