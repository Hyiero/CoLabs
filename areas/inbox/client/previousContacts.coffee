Template.previousContacts.helpers
  contactList: ->
    contactIds = Meteor.users.findOne(
      _id: Meteor.userId()
    ).contacts
    contactList = (Meteor.users.findOne(
      _id: contact
    ) for contact in contactIds)

Template.previousContacts.events
  "click .conversation": (event)->
    $elem = $ event.currentTarget
    if $elem.hasClass "media-body"
      $elem = $elem.parent()
    contactId = $elem.attr "value"
    if contactId != Session.get("currentContact")?._id
      contact = Meteor.users.findOne _id:contactId
      Session.set "currentContact", contact
