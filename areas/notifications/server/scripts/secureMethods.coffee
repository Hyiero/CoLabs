Meteor.publish('allNotifications',()->
  Notifications.find()
)
Logger.enable()

Meteor.methods(
  sendNotification:(notificationModel)->
    Notifications.insert(
      {
        type:notificationModel.type,
        date:notificationModel.date,
        sender:notificationModel.sender
      }
    )

  )
