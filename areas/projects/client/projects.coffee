Template.projects.onCreated ->
  @subscribe 'myProjects'

Template.projects.helpers
  projects: -> Projects.find().fetch()

Template.project.helpers
  editProjectButton: -> Render.button
    type: 'primary'
    icon: 'edit'
    text: "Edit Project"
    dataId: @_id
    onclick: ->
      project = Projects.findOne @data 'id'
      Session.set "projectId" , project._id
      Session.set 'editProject', true
  addUsersButton: -> Render.button
    type: 'info'
    icon: 'user'
    text: "Add Users"
    dataId: @_id
    onclick: ->
      Session.set 'selectedProjectId', @data 'id'
      Router.go '/inviteUsers'
  removeMeButton: -> Render.buttonDelete
    icon: 'remove'
    text: "Remove Me"
    dataId: @_id
    onclick: ->
      Meteor.call 'removeUserFromProject',
        projectId: @data 'id'
        userId: Meteor.userId()
  users: -> Meteor.users.find { $in: @users }
  username: (id) -> Meteor.users.findOne(id)?.username

Template.projectForm.events
  "submit projectSubmitForm": (e) -> e.preventDefault()

Template.projectForm.helpers
  buttonCancel: -> Render.buttonCancel
    icon: 'hand-o-left'
    text: 'Back'
    onclick: -> Session.set 'editProject', false
    
  buttonSubmit: -> Render.buttonSave
    text: 'Save Project'
    onclick: ->
      data =
        id: Session.get 'projectId'
        name: $('#projectName').val()
        description: $('#projectDescription').val()
      Meteor.call 'updateProject', data, (err, res) ->
        if err then console.log err
        else Session.set 'editProject', false
      false
  
  #TODO: Popup form to create new
  buttonAddNew: -> Render.button
    icon: 'plus'
    text: 'Add New'
    type: 'success'
    class: 'pull-right'
    onclick: ->
      Meteor.call 'createProject', user:Meteor.user(), (err, res) ->
        if err then console.error err
        else Session.set 'editProject', false

  projectName: -> @projectName or ''
  projectDescription: -> @projectDescription or ''
  edit: -> Session.get 'editProject'
