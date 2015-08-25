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
      {
        name:data.name,
        description:data.description
      }
    )

  'removeUserFromProject': () ->
    1 #fix this, data not going over for some reason
    #project=Projects.findOne({_id:data.projectId})

    #project.users.remove(data.userId)

    #Projects.update(
      #{id:data.projectId},
      #{
        #users:project.users
      #}
    #)


  'getMyProjects':(id) ->
    Projects.find({users:id})


  'letsTryThisOne': ()->
    1
)