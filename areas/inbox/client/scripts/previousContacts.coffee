Template.previousContacts.helpers
  contactList: ->
    contactIds = Meteor.users.findOne(
      _id: Meteor.userId()
    ).contacts
    contactList = (Meteor.users.findOne(
      _id: contact
    ) for contact in contactIds)

Template.previousContacts.events
  "click #conversation": ->
    #set currentContact to contact from click item
