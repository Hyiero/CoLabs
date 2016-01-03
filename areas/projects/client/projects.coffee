Template.projects.onCreated ->
  @subscribe 'myProjects'

Template.projects.helpers
  buttonAddNew: -> Render.button
    icon: 'plus'
    text: 'Add New'
    type: 'success'
    class: 'pull-right'
    onclick: -> Modal.show 'createProjectModal'
  projects: -> Projects.find(admins: Meteor.userId()).fetch()

Template.project.onCreated ->
  @subscribe 'projectUsers', @data._id

Template.project.helpers
  dashboardButton: -> Render.button
    icon: 'folder'
    text: 'Project Dashboard'
    dataId: @_id
    onclick: -> Router.go "/project/#{@data 'id'}"
  removeMeButton: -> Render.buttonDelete
    icon: 'remove'
    text: 'Remove Me'
    dataId: @_id
    onclick: ->
      # TODO: Add warning modal
      Meteor.call 'removeUserFromProject',
        projectId: @data 'id'
        userId: Meteor.userId()
  editProjectButton: -> Render.button
    type: 'primary'
    icon: 'edit'
    text: 'Project Settings'
    dataId: @_id
    onclick: -> Router.go "/project/#{@data 'id'}/settings"
  users: -> Meteor.users.find _id: $in: @users
  username: (id) -> Meteor.users.findOne(id)?.username

Template.createProjectModal.helpers
  buttonClose: -> Render.buttonClose
    class: 'pull-right'
    dataDismiss: 'modal'
  createProjectButton: -> Render.buttonSave
    text: 'Create Project'
    dataDismiss: 'modal'
    onclick: ->
      Meteor.call 'createProject', {
        name: $('#projectName').val()
        description: $('#projectDescription').val()
      },(err, res) ->
        Meteor.subscribe 'myProjects'
