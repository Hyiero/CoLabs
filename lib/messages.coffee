@Messages = new Mongo.Collection('messages')

Messages.messagesWithContact = (user, contact)->
  Messages.find(
    $or: [
      to: user
      from: contact,
      to: contact
      from: user
    ]
  ).fetch().sort( {timeStamp: 1} )

