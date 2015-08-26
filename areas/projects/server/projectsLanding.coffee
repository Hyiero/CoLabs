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
    Projects.findOne({_id:data.projectId}).users    


  'getMyProjects':(id) ->
    Projects.find({users:id})

)