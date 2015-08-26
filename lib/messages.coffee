@Messages = new Mongo.Collection('messages')

Messages.messagesWithContact = (user, contact)->
  Messages.find(
    to: user
    from: contact
  ).fetch()
