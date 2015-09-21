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
    Messages.insert {
      to: messageModel.to
      from: messageModel.from
      message: messageModel.message
      timeStamp: messageModel.timeStamp
      read: false},
      (err, doc)->
        unless err?
          updateConversation messageModel.to, messageModel.from, doc
          updateConversation messageModel.from, messageModel.to, doc
  readMessages: (pair)->
    Messages.update {
      to: pair.user
      from: pair.contact
    }, { $set:
      read: true }, multi: true
  addContact: (pair)->
    contacts = Meteor.users.findOne(pair.user).contacts
    contacts.unshift contact: pair.contact, favorite: false
    Meteor.users.update pair.user,  $set:
      contacts: contacts
  toggleContact: (pair)->
    contacts = Meteor.users.findOne(
      _id: pair.user
    ).contacts
    for contact in contacts
      if contact.contact is pair.contact
        contact.favorite = not contact.favorite
    Meteor.users.update pair.user, $set:
      contacts: contacts
