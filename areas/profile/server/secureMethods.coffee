Users.InsertOne = (newUser) ->
  Meteor.users.insert newUser

Meteor.methods(

  updateUser: (id, updateObject) ->
    user = Meteor.users.findOne(_id: id)
    email = user.emails[0]
    
    if not email or email.address isnt updateObject.email
      emails = [address: updateObject.email, verified: false]
    
    Logger.enable()
    console.info user
    
    Meteor.users.update _id: id,
      $set: {
          emails: emails or user.emails
          avatar: updateObject.avatar
          firstName: updateObject.firstName
          lastName: updateObject.lastName
          age: updateObject.age
          tags: updateObject.tags
        },
        -> console.info Meteor.users.findOne(_id: id)

  updateName: (id,newName) ->
    Meteor.users.update _id: id,
      $set: { name: newName }
    
  sendVerificationEmail: (userId) ->
    Accounts.sendVerificationEmail userId
    
)
