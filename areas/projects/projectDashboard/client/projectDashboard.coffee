Template.projectDashboard.onCreated ->
  Meteor.subscribe 'oneProject', Router.current().params.id

Template.projectDashboard.helpers
  project: -> Projects.findOne()

Template.projectChat.onCreated ->
  Meteor.subscribe 'oneProject', Router.current().params.id
  Meteor.subscribe 'projectUsers', Router.current().params.id

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