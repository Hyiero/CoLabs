@CoLabs = {}
CoLabs.methodNames = []
CoLabs.methods = (obj) ->
  for name,v of obj
    CoLabs.methodNames.push name
  Meteor.methods obj

CoLabs.methods
  updateUser: (id, updateObject) ->
    user = Meteor.users.findOne(_id: id)
    email = user.emails[0]
    
    if not email or email.address isnt updateObject.email
      emails = [address: updateObject.email, verified: false]
    
    Logger.enable()
    console.info user
    
    result = Meteor.users.update _id: id,
      $set: {
          emails: emails or user.emails
          avatar: updateObject.avatar
          firstName: updateObject.firstName
          lastName: updateObject.lastName
          age: updateObject.age
          tags: updateObject.tags
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