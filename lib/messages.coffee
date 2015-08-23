@Messages = new Mongo.Collection('messages')

Messages.messagesWithContact = (user, contact)->
  Messages.find(
    $or: [
      $to: user
      $from: contact,
      $to: contact
      $from: user
    ]
    $orderby:
      timeStamp: 1
  ).fetch()

