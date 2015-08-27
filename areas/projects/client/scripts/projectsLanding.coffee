Template.projectsLanding.helpers
  projects: Projects.find().fetch()

Template.project.helpers
  users: ->
    Users.find(
      _id: { $in: @users }
    )

Template.projectForm.events
  'click #submitProject': (e) ->
    e.preventDefault()
    data = {
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
    Session.set 'editProject', true

  'click button.remove': (e) ->
    e.preventDefault()
    projectId=e.currentTarget.attributes["value"].value
    data= {
      projectId: projectId,
      userId: Meteor.userId()
    }
    console.log Meteor.user().projects.length
    Meteor.call 'removeUserFromProject', data, (err,data) ->
        console.log(data)
    console.log Meteor.user().projects.length

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