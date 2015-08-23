Meteor.methods(
  'createProject': (data) ->
    userId = Meteor.user()._id
    Projects.insert(
      name: data.name,
      description: data.description
      lastUpdated: new Date()
      users: [userId]
    )
)