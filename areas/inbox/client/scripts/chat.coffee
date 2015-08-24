Meteor.subscribe('allMessages')

Template.chat.helpers
  currentConversation: ->
    test = Messages.messagesWithContact(Meteor.userId(), (Session.get "currentContact")._id)
    console.log(test)
    currentConversation = test
  currentContactName: ->
    currentContactName = Session.get("currentContact").username
  userName: ->
    userName = Meteor.user().username

Template.chat.events
  "click #submitMessage": ->
    messageModel =
      to: (Session.get "currentContact")._id
      from: Meteor.userId()
      message: $('#messageContent').val()
      timeStamp: new Date()
    Meteor.call('addMessage', messageModel)
    $('#messageContent').val("")
