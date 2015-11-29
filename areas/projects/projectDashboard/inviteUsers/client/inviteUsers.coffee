Template.inviteUsers.onCreated ->
  @subscribe 'allUsers'
  @subscribe 'oneProject', Session.get 'selectedProjectId'

Template.inviteUsers.helpers
  filteredUsers: ->
    excludedUsers = Projects.findOne().users
    Meteor.users.find(_id: $nin: excludedUsers).fetch()
