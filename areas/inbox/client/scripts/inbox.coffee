Meteor.subscribe('allMessages')

Template.chat.helpers
  currentConversation: ->
    test = Messages.messagesWithContact(Meteor.userId(), (Session.get "currentContact")._id)
    currentConversation = test
  currentContactName: ->
    currentContactName = Session.get("currentContact").name

Template.chat.events
  "click #submitMessage": ->
    message = $('#messageContent').val()
    Meteor.call('addMessage', [(Session.get "currentContact")._id, Meteor.userId(), message, new Date()])
    console.log(messages: Messages.find().fetch())