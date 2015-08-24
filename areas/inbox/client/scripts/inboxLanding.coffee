Template.inboxLanding.helpers(
  setupCurrentContactInSession: ->
    currentContact=Session.get('currentContact')
    if(!currentContact?)
      console.log("contact was null")
      Session.set('currentContact',Meteor.user())
)