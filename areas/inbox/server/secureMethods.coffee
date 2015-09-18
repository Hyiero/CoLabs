CoLabs.methods
  addMessage: (messageModel)->
    Messages.insert
      to: messageModel.to
      from: messageModel.from
      message: messageModel.message
      timeStamp: messageModel.timeStamp
      read: false
  readMessages: (pair)->
    Messages.update {
      to: pair.user
      from: pair.contact
    }, { $set:
      read: true }, multi: true
  addContact: (pair)->
    contacts = Meteor.users.findOne(
      _id: pair.user
    ).contacts
    contacts.unshift contact: pair.contact, favorite: false
    Meteor.users.update { _id: pair.user },  $set:
      contacts: contacts
  #toggleContact: (pair)->
