Template.inviteUsers.onCreated ->
  @subscribe 'allUsers'
  @subscribe 'projectNotifications', Router.current().params.id
  @subscribe 'oneProject', Router.current().params.id

Template.inviteUsers.helpers
  filteredUsers: ->
    projectUsers = Projects.findOne().users
    invitedUsers = (notification.userId for notification in Notifications.find().fetch())
    excludedUsers = projectUsers.concat invitedUsers
    Meteor.users.find(_id: $nin: excludedUsers).fetch()
