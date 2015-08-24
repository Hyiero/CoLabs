Meteor.methods(
  addMessage: (to, from, message, timeStamp)->
    console.log(to)
    Messages.insert(to: to, from: from, message: message, timeStamp: timeStamp)
    ###
    FIXME: Inserts wrong structure
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