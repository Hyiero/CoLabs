CoLabs.methods
  addMessageToProject: (data)->
    user = Meteor.userId()
    project = Projects.findOne data.project
    if user in project.users
      conv = project.conversation
      conv.push
        from: user
        message: data.message
        timeStamp: Date.now()
      Projects.update data.project, $set:
        conversation: conv