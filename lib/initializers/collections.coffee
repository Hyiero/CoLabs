@Projects = new Mongo.Collection('projects')
@Notifications = new Mongo.Collection('notifications')
@Invitations =  new Mongo.Collection('invitations')
@Messages = new Mongo.Collection('messages')

Messages.messagesBetween = (user1, user2)->
  Messages.find(
    $or: [
      to: user1
      from: user2,
      to: user2
      from: user1
    ]).fetch()

Messages.newMessages = (user)->
  Messages.find(
    to: user
    read: false
  ).fetch()
