@Messages = new Mongo.Collection('messages')

Messages.messagesBetween = (user1, user2)->
  to = Messages.find(to: user1, from: user2).fetch()
  from = Messages.find(to: user2, from: user1).fetch()
  to.concat from

Messages.messagesOf = (user)->
  to = Messages.find(to: user).fetch()
  from = Messages.find(from: user).fetch()
  to.concat from

Messages.newMessages = (user)->
  Messages.find(
    to: user
    read: false
  ).fetch()
