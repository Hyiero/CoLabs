CoLabs.methods
  adminPower: (obj)->
    {target, command} = obj
    Meteor.users.update target, $set:
      isAdmin: if command is "grant" then true else undefined