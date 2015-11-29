CoLabs.methods
  respondToInvite: (data)->
    notification = Notifications.findOne data.notificationId
    projectId = notification.data.projectId
    userId = notification.userId
    status = if data.isAccept then 'accepted' else 'declined'
    Notifications.update data.notificationId, $set:
      data:
        status: status
    ###
    TODO: Project admins can see project notifications
    Notifications.insert
      projectId: projectId
      type: 'inviteResponse'
      data:
        userId: userId
        status: status
    ###
    users = Projects.findOne(projectId).users
    users.push userId
    Projects.update projectId, $set:
      users: users
