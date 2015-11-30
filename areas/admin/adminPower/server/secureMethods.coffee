CoLabs.methods
  adminPower: (data)->
    if CoLabs.isAdmin()
      { target, command } = data
      Meteor.users.update target, $set:
        isAdmin: if command is "grant" then true else undefined
