
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

removeAdminFromProject= (data) ->
  project=Projects.findOne({_id:data.projectId})
  userIndex=project.admins.indexOf(data.userId)
  if userIndex>-1
    project.admins.splice(userIndex,1)
    Projects.update(
      {_id:data.projectId},
      {$set:
        {
          admins:project.admins
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
      lastUpdated: new Date().toLocaleString()
      users: [userId]
      admins: [userId]
      owner: userId
      creator: userId
      privacyLevel: 'public'
      tags: []
      type: 'project'
    )

  'updateProject': (data) ->
    Projects.update(
      {_id:data.id},
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
     removeAdminFromProject data


  'getMyProjects': (id) ->
    Projects.find({users:id})
    
  'inviteUserToProject': (userId,projectId) -> 
    Invitations.insert(
        user:userId,
        project:projectId,
        date: new Date().toLocaleString()
        )   
  
  'addUserToProject': (userId,projectId) ->
     project=Projects.findOne({_id:projectId})
     if project??
        currentUsers=project.users
        currentUsers.push(userId)
        updated=Projects.update(
            {_id:projectId},
            {$set:
                 {
                    users:currentUsers
                 }
            }
        )
        updated
    
  'removeInvitation':(id)->
     Invitations.remove({_id:id})

)


    