Template.otherProfile.onCreated ->
  @subscribe 'oneUserByName', Router.current().params.username

Template.otherProfile.helpers
  user: -> Meteor.users.findOne username: Router.current().params.username
