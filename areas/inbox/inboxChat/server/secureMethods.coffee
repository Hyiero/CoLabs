updateConversation = (user, contact, message)->
  conversations = Meteor.users.findOne(user).conversations
  for conversation in conversations
    if conversation.contact is contact
      conversation.message = message
      found = true
      break
  unless found? then conversations.unshift contact: contact, message: message
  Meteor.users.update user, $set:
    conversations: conversations

CoLabs.methods
  addMessage: (messageModel)->
    user = Meteor.userId()
    Messages.insert {
      to: messageModel.to
      from: user
      message: messageModel.message
      timeStamp: messageModel.timeStamp
      read: false },
      (err, doc)->
        unless err?
          updateConversation messageModel.to, user, doc
          updateConversation user, messageModel.to, doc
  readMessages: (contact)->
    Messages.update {
      to: Meteor.userId()
      from: contact
    }, { $set:
      read: true }, multi: true
  addContact: (contact)->
    user = Meteor.userId()
    contacts = Meteor.users.findOne(user).contacts
    contacts.unshift contact: contact, favorite: false
    Meteor.users.update user, $set:
      contacts: contacts