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
      project = Projects.findOne _id: @data 'id'
      Session.set "projectDescription", project.description
      Session.set "projectName" , project.name
      Session.set "projectId" , projectId
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
  users: -> Users.find _id: { $in: @users }
  username: (id) -> Meteor.users.findOne(_id:id)?.username

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


Template.inviteUsersButtons.events 
  "click #inviteUsersToProject": (event) ->
    selectedCheckboxes=$('.selectedUserCheckbox')
    for checkbox in selectedCheckboxes
      if(checkbox.checked)
        userId=checkbox.attributes["value"].value
        invited=CoLabs.IsUserInvitedToProject(userId,Session.get("selectedProjectId"))
        cb={}
        console.log invited
        if invited is "false"
          Meteor.call 'inviteUserToProject', userId, Session.get("selectedProjectId"), (err,data) ->
            if data == true then toast.success "Invitation","User invited to project",5000
            else toast.danger "Invitation","Something went wrong while sending the invitation",5000
        else
          toast.warning "Invitation",
            "This user has a pending invitation to this project.",
            3000