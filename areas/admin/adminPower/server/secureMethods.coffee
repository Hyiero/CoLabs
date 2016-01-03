CoLabs.methods
  adminPower: (data)->
    if CoLabs.isAdmin()
      { target, command } = data
      Meteor.users.update target, $set:
        isAdmin: command is "grant"
      Notifications.insert
        userId: target
        type: 'general'
        timeStamp: new Date()
        data:
          status: 'none'
          message: "You have #{if command is 'grant' then 'been granted' else 'lost'} CoLabs admin power"
