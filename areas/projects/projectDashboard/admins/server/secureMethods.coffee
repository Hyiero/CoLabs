CoLabs.methods
  grantProjectAdmin: (data)->
    project = Projects.findOne data.projectId
    if Meteor.userId() in project.admins
      admins = project.admins.concat [ data.userId ]
      Projects.update data.projectId, $set:
        admins: admins
      Notifications.insert
        userId: data.userId
        type: 'general'
        timeStamp: new Date()
        data:
          status: 'none'
          message: "You are now an admin of project #{project.name}"
