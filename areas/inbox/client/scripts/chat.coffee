Meteor.subscribe('allMessages')

UI.registerHelper 'nameOf', (id)->
  user = Meteor.users.findOne
    _id: id
  user.name

Template.chat.helpers
  currentConversation: ->
    user = Meteor.userId()
    contact = (Session.get "currentContact")._id
    to = Messages.messagesWithContact(user, contact)
    from = Messages.messagesWithContact(contact, user)
    conv = to.concat(from)
    conv.sort (a, b)->
      a.timeStamp - b.timeStamp
    currentConversation = conv
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
