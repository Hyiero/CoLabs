CoLabs.methods
  removeUser: (userId)->
    Meteor.users.remove { _id: userId }
    Notifications.remove { sender: userId }

  addTag: (value)->
    Tags.insert
      value: value
      status: 'none'