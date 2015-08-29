Template.projectsLanding.helpers
  projects: Projects.find().fetch()

Template.project.helpers
  users: ->
    Users.find(
      _id: { $in: @users }
    )
  username: (id)->
    thisUser=Meteor.users.findOne({_id:id})
    thisUser.username

Template.projectForm.events
  'click #submitProject': (e) ->
    e.preventDefault()
    data = {
      id: Session.get 'projectId'
      name: $('#projectName').val()
      description: $('#projectDescription').val()
    }
    Meteor.call 'updateProject', data, (err, res) ->
      if err then console.log err
      else Session.set 'editProject', false

  'click button.edit': (e) ->
    e.preventDefault()
    projectId=e.currentTarget.attributes["value"].value
    project=Projects.findOne({_id:projectId})

    Session.set "projectDescription", project.description
    Session.set "projectName" , project.name
    Session.set "projectId" , projectId
    Session.set 'editProject', true

  'click button.remove': (e) ->
    e.preventDefault()
    projectId=e.currentTarget.attributes["value"].value
    data= {
      projectId: projectId,
      userId: Meteor.userId()
    }
    Meteor.call 'removeUserFromProject', data
    
  'click button.addUsers': (e) ->
    e.preventDefault()
    projectId=e.currentTarget.attributes["value"].value
    Session.set 'selectedProjectId', projectId
    Router.go '/search/addUserToProjectSearch'
    

  'click #goBack': (e) ->
    e.preventDefault()
    Session.set 'editProject', false

  'click #addNew': (e) ->
    e.preventDefault()
    data={
      user:Meteor.user()
    }
    Meteor.call 'createProject', data, (err, res) ->
      if err then console.error err
      else Session.set 'editProject', false


Template.projectForm.helpers
  projectName: ->
    @projectName or ''
  projectDescription: ->
    @projectDescription or ''
  edit: -> Session.get 'editProject'