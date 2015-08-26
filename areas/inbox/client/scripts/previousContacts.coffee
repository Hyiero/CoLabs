Template.previousContacts.helpers
  contactList: ->
    contactIds = Meteor.users.find(
      _id: Meteor.userId()
    ).fetch()
    #get list of users using contactIds

Template.previousContacts.events
  "click #conversation": ->
    #set currentContact to contact from click item