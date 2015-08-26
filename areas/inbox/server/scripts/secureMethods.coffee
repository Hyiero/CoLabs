Meteor.methods(
  addMessage: (messageModel)->
    Messages.insert
      to: messageModel.to
      from: messageModel.from
      message: messageModel.message
      timeStamp: messageModel.timeStamp
  addContact: (pair)->
    contacts = Meteor.users.findOne(
      _id: pair.user
    ).contacts
    contacts.unshift pair.contact
    Meteor.users.update { _id: pair.user },  $set:
      contacts: contacts
)