@Messages = new Mongo.Collection('messages')

Messages.messagesWithContact = (user, contact)->
  Messages.find(
    to: user
    from: contact
  ).fetch()

Messages.newMessages = (user)->
  Messages.find(
    to: user
    read: false
  ).fetch()
