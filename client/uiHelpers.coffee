UI.registerAllHelpers = (helperMap) ->
  UI.registerHelper name, fn for name, fn of helperMap


splitTimeStamp = (timeStamp) ->
  timeStamp = new Date timeStamp unless timeStamp.getDate?
  date: timeStamp.toLocaleDateString()
  time: timeStamp.toLocaleTimeString()

formatDateTime = (timeStamp) ->
  today = (new Date()).toLocaleDateString()
  {date, time} = splitTimeStamp timeStamp
  if date is today then "Today, #{time}" else "#{date}, #{time}"


UI.registerAllHelpers
  prettyDateTime: (date) -> formatDateTime date
  nameOf: (id) -> Meteor.users.findOne(id).name
  descriptionOf: (id) -> Meteor.users.findOne(id).description
