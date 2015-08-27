
removeUserFromProject= (data) ->
    project=Projects.findOne({_id:data.projectId})
    userIndex=project.users.indexOf(data.userId)
    project.users.splice(userIndex,1)

    Projects.update(
      {_id:data.projectId},
      {$set:
        {
         users:project.users
        }
      }
    )

removeProjectFromUser= (data) ->
    thisUser=Meteor.users.findOne({_id:data.userId})
    projectIndex=thisUser.projects.indexOf(data.projectId)
    thisUser.projects.splice(projectIndex,1)
    
    Meteor.users.update(
        {_id:data.userId}
        {$set:
         {
            projects:thisUser.projects
         }
        }
    )

Meteor.methods(
  'createProject': (data) ->
    userId = Meteor.user()._id
    Projects.insert(
      name: data.name,
      description: data.description
      lastUpdated: new Date()
      users: [userId]
      admins: [userId]
      owner: userId
      creator: userId
      privacyLevel: 'public'
    )

  'updateProject': (data) ->
    Projects.update(
      {id:data.id},
      {$set:
          {
            name:data.name,
            description:data.description
          }
      }
    )

  'removeUserFromProject': (data) ->
     removeUserFromProject data
     removeProjectFromUser data  


  'getMyProjects':(id) ->
    Projects.find({users:id})

)


    