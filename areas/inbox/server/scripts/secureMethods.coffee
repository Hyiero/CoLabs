Meteor.methods(
  addMessage: (to, from, message, timeStamp)->
    Messages.insert(to:to, from:from, message:message, timeStamp:timeStamp)
)