Meteor.subscribe "allMessages"

userExists = (id)-> Meteor.users.findOne(id)?

getPair = ()->
  user: Meteor.userId()
  contact: Session.get "currentContact"

splitTimeStamp = (timeStamp)->
  date: timeStamp.toLocaleDateString()
  time: timeStamp.toLocaleTimeString()

UI.registerHelper "nameOf", (id)-> Meteor.users.findOne(id).name

UI.registerHelper "cleanup", (timeStamp)->
  today = (new Date()).toLocaleDateString()
  {date, time} = splitTimeStamp timeStamp
  if date is today then "Today, #{time}" else "#{date}, #{time}"

Template.chat.helpers
  contactExists: (contactId)-> userExists contactId
  contactSelected: ()-> Session.get("currentContact")?
  currentConversation: ()->
    pair = getPair()
    {user, contact} = pair
    Meteor.call "readMessages", pair
    to = Messages.messagesWithContact user, contact
    from = Messages.messagesWithContact contact, user
    conv = to.concat(from)
    conv.sort (a, b)->
      a.timeStamp - b.timeStamp
  currentContactName: ()->
    contactId = Session.get "currentContact"
    contact = Meteor.users.findOne contactId
    contact?.username or "Deleted User"
  userName: ()-> Meteor.user().username

Template.chat.events
  "click #submitMessage": ()->
    pair = getPair()
    {user, contact} = pair
    messageModel =
      to: contact
      from: user
      message: $("#messageContent").val()
      timeStamp: new Date()
    Meteor.call("addContact", pair) unless Messages.findOne(to: contact, from: user)?
    Meteor.call "addMessage", messageModel
    $("#messageContent").val ""

Template.previousContacts.helpers
  contactList: ()-> Meteor.user().contacts.sort (a, b)-> b.favorite - a.favorite
  contactExists: (contactId)-> userExists contactId

Template.previousContacts.events
  "click .conversation": (event)->
    $elem = $ event.currentTarget
    if $elem.hasClass "media-body" then $elem = $elem.parent()
    Session.set "currentContact", $elem.data "id"

Template.favoriteContact.helpers
  isFavorite: (contactId)->
    contacts = Meteor.user().contacts
    for contact in contacts
      if contact.contact is contactId
        return contact.favorite

Template.favoriteContact.events
  "click #favorite": (event)->
    $elem = $ event.currentTarget
    Meteor.call "toggleContact", {user: Meteor.userId(), contact: $elem.data "id"}
