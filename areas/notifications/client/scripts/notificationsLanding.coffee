Meteor.subscribe('allNotifications')

@SendOneNotification=(type,date,sender)->
  console.log(type+","+date+","+sender)
  Meteor.call('sendNotification',
    {
      type:type,
      date:date,
      sender:sender
    }
  )