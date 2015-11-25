
removeUserFromProject = (data)->
  project = Projects.findOne data.projectId
  users = project.users.filter (id)-> id isnt data.userId
  admins = project.admins.filter (id)-> id isnt data.userId
  # TODO: Handle case when no admins remain
  if users.length is 0 then Projects.remove data.projectId
  else Projects.update data.projectId, $set:
    users: users
    admins: admins

removeProjectFromUser = (data)->
  user = Meteor.users.findOne data.userId
  projects = user.projects.filter (id)-> id isnt data.userId
  Meteor.users.update data.userId, $set:
    projects: projects

CoLabs.methods
  createProject: (data)->
    userId = Meteor.userId()
    Projects.insert
      name: data.name
      description: data.description
      createdAt: Date.now()
      users: [userId]
      admins: [userId]
      tags: []
      conversation: []
      type: 'project'

  updateProject: (data)->
    Projects.update data.id, $set:
      name: data.name
      description: data.description

  removeUserFromProject: (data)->
    removeUserFromProject data
    removeProjectFromUser data
    
  inviteUserToProject: (data)->
    Invitations.insert
      user: data.user
      project: data.project
      date: new Date().toLocaleString()

  addUserToProject: (userId,projectId)->
    project = Projects.findOne projectId
    if project?
      currentUsers = project.users
      currentUsers.push userId
      Projects.update projectId, $set:
        users: currentUsers
    
  removeInvitation: (id)->
    Invitations.remove id
