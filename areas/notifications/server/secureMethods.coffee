CoLabs.methods
  sendNotification: (data)->
    Notifications.insert
      type: data.type
      date: data.date
      sender: data.sender