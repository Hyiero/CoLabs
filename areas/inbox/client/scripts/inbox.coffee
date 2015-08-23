Meteor.subscribe('allMessages')

Template.previousContacts.helpers
  contactList: ->

Template.chat.helpers
  currentConversation: ->
    Messages.messagesWithContact(Meteor.userId(), (Session.get "currentContact")._id)
  currentContactName: ->
    Session.get("currentContact").name

Template.chat.events
  "click #submitMessage": ->
    message = $('#messageContent').val()
    console.log(Meteor.call('addMessage', (Session.get "currentContact")._id, Meteor.userId(), message, new Date()))