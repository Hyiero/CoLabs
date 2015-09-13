Meteor.publish 'allNotifications', ->
  Notifications.find()

Logger.enable()

CoLabs.methods
  sendNotification: (notificationModel)->
    Notifications.insert
      type:notificationModel.type,
      date:notificationModel.date,
      sender:notificationModel.sender