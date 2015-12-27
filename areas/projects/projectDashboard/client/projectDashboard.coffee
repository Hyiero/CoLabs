Template.projectDashboard.onCreated ->
  @subscribe 'oneProject', Router.current().params.id

Template.projectDashboard.helpers
  projectSettingsButton: -> Render.button
    type: 'primary'
    text: 'Project Settings'
    icon: 'edit'
    onclick: -> Router.go "/project/#{Router.current().params.id}/settings"
  project: -> Projects.findOne()
  isProjectAdmin: -> Meteor.userId() in Projects.findOne().admins

Template.projectChat.onCreated ->
  @subscribe 'oneProject', Router.current().params.id
  @subscribe 'projectUsers', Router.current().params.id

Template.projectChat.helpers
  contactExists: (id) -> Meteor.users.findOne(id)?
  conversation: -> Projects.findOne().conversation
  userInProject: -> Meteor.userId() in Projects.findOne().users

Template.projectChat.events
  'click #submitMessage': ->
    Meteor.call 'addMessageToProject',
      project: Router.current().params.id
      message: $('#messageContent').val()
    $('#messageContent').val ''