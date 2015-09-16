Meteor.subscribe "allMessages"

UI.registerHelper "nameOf", (id)->
  user = Meteor.users.findOne
    _id: id
  user.name

UI.registerHelper "cleanup", (timeStamp)->
  now = new Date()
  now =
    date: now.toLocaleDateString()
    time: now.toLocaleTimeString()
  timeStamp =
    date: timeStamp.toLocaleDateString()
    time: timeStamp.toLocaleTimeString()
  if now.date == timeStamp.date
    result = "Today, #{timeStamp.time}"
  else
    result = "#{timeStamp.date}, #{timeStamp.time}"
  result

Template.chat.helpers
  contactExists: ->
    contactId = Session.get("currentContact")
    contact = Meteor.users.findOne { _id: contactId }
    contactExists = contact?
  contactSelected: ->
    Session.get("currentContact")?
  currentConversation: ->
    user = Meteor.userId()
    contact = Session.get "currentContact"
    to = Messages.messagesWithContact(user, contact)
    from = Messages.messagesWithContact(contact, user)
    conv = to.concat(from)
    conv.sort (a, b)->
      a.timeStamp - b.timeStamp
    currentConversation = conv
  currentContactName: ->
    contactId = Session.get "currentContact"
    contact = Meteor.users.findOne { _id: contactId }
    currentContactName = contact?.username or "Deleted User"
  userName: ->
    userName = Meteor.user().username

Template.chat.events
  "click #submitMessage": ->
    user = Meteor.userId()
    contact = (Session.get "currentContact")
    pair =
      user: user
      contact: contact
    messageModel =
      to: contact
      from: user
      message: $("#messageContent").val()
      timeStamp: new Date()
    Meteor.call("addContact", pair) unless Messages.findOne(
      to: contact
      from: user
    )?
    Meteor.call "addMessage", messageModel
    $("#messageContent").val ""
