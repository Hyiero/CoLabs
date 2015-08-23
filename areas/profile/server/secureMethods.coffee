Users.InsertOne = (newUser)->
  Meteor.users.insert(newUser)

Meteor.methods(
  updateUser: (id, updateObject)->
    Meteor.users.update(
      {_id: id},
      {$set:
        {
          avatar: updateObject.avatar,
          firstName: updateObject.firstName,
          lastName: updateObject.lastName,
          age: updateObject.age,
          interests: updateObject.interests
        }
      }
    )
)

