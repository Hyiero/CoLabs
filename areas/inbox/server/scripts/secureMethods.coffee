Meteor.methods(
  addMessage: (to, from, message, timeStamp)->
    Messages.insert(to: to, from: from, message: message, timeStamp: timeStamp)
    ###
    FIXME: Inserts with wrong structure
    Current:
    {
      to: [
        to,
        from,
        message,
        timeStamp
      ]
      from: null
      message: null
      timeStamp: null
    }
  
    Correct:
    {
      to: to
      from: from
      message: message
      timeStamp: timeStamp
    }
    ###
)