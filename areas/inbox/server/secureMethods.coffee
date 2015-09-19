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
