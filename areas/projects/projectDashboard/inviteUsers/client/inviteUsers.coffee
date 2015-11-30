Template.inviteUsers.onCreated ->
  @subscribe 'allUsers'
  @subscribe 'projectNotifications', Session.get 'selectedProjectId'
  @subscribe 'oneProject', Session.get 'selectedProjectId'

Template.inviteUsers.helpers
  filteredUsers: ->
    projectUsers = Projects.findOne().users
    invitedUsers = (notification.userId for notification in Notifications.find().fetch())
    excludedUsers = projectUsers.concat invitedUsers
    Meteor.users.find(_id: $nin: excludedUsers).fetch()
