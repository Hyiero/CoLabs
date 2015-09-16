UI.registerHelper "nameOf", (id)->
  user = Meteor.users.findOne
    _id: id
  user.name

Template.previousContacts.helpers
  contactList: ->
    contactIds = Meteor.users.findOne(
      _id: Meteor.userId()
    ).contacts
  contactExists: (contactId)->
    contact = Meteor.users.findOne { _id: contactId }
    contactExists = contact?

Template.previousContacts.events
  "click .conversation": (event)->
    $elem = $ event.currentTarget
    if $elem.hasClass "media-body"
      $elem = $elem.parent()
    contactId = $elem.attr "value"
    Session.set "currentContact", contactId
