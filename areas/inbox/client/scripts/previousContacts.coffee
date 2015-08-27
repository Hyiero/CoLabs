Template.previousContacts.helpers
  contactList: ->
    contactIds = Meteor.users.findOne(
      _id: Meteor.userId()
    ).contacts
    contactList = (Meteor.users.findOne(
      _id: contact
    ) for contact in contactIds)

Template.previousContacts.events
  "click #conversation": (event)->
    console.log("click")
    contactId = event.target.attributes['value'].value
    contact = Meteor.users.findOne({_id:contactId})
    Session.set "currentContact", contact
