Template.inboxLanding.helpers(
  setupCurrentContactInSession: ->
    Session.set('currentContact',Meteor.user())
)