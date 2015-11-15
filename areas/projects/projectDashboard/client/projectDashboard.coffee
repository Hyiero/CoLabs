Template.projectDashboard.onCreated ->
  Meteor.subscribe 'oneProject', Router.current().params.id

Template.projectDashboard.helpers
  project: -> Projects.findOne()