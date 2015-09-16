@CoLabs = {}
CoLabs.methodNames = []
CoLabs.methods = (obj) ->
  for name,v of obj
    CoLabs.methodNames.push name
  Meteor.methods obj

CoLabs.methods
  updateUser: (obj) ->
    id = this.userId
    user = Meteor.users.findOne(_id: id)
    email = user.emails[0]
    
    if not email or email.address isnt obj.email
      emails = [address: obj.email or false, verified: false]
    
    Logger.enable()
    console.info user
    
    result = Meteor.users.update _id: id,
      $set: {
          emails: emails or user.emails
          avatar: obj.avatar
          firstName: obj.firstName
          lastName: obj.lastName
          age: obj.age
          tags: obj.tags
          identiconHex: obj.identiconHex
        },
        -> console.info Meteor.users.findOne(_id: id)
    !result? or false

  updateName: (id,newName) ->
    Meteor.users.update _id: id,
      $set: { name: newName }
    
  sendVerificationEmail: (userId) ->
    Logger.enable()
    console.info userId
    if Meteor.isServer then Accounts.sendVerificationEmail userId