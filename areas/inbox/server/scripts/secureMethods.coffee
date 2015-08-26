Meteor.methods(
  addMessage: (messageModel)->
    Messages.insert
      to: messageModel.to
      from: messageModel.from
      message: messageModel.message
      timeStamp: messageModel.timeStamp
  addContact: (pair)->
    contacts = Meteor.users.find(
      _id: pair.user
    ).fetch().contacts
    contacts.unshift pair.contact
    Meteor.users.update
      _id: pair.user
      contacts: contacts
)