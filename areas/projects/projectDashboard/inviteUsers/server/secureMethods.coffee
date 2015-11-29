CoLabs.methods
  inviteUserToProject: (data) ->
    { userId, projectId } = data
    project = Projects.findOne projectId
    if Meteor.userId() in project.admins
      Notifications.insert
        userId: userId
        type: 'invite'
        timeStamp: Date.now()
        data:
          projectId: projectId
          status: 'none'
