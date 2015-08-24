Meteor.methods(
  addMessage: (messageModel)->
    Messages.insert
      to: messageModel.to
      from: messageModel.from
      message: messageModel.message
      timeStamp: messageModel.timeStamp
)