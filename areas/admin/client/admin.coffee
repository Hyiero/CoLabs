Template.admin.events
  "click #runTerminal": ->
    console.log(eval($('[name=command]').val()))

Template.enableLogs.onCreated = ->
  Logger.enable()
  Session.set 'logEnabled', true

Template.enableLogs.helpers
  isEnabled: -> Session.get 'logEnabled'
  
Template.enableLogs.events
  "click #enableLogs": ->
    toast.info 'Clicked', Logger.isEnabled, 1000
    if Logger.isEnabled then Logger.disable()
    else Logger.enable()
    Session.set 'logEnabled', Logger.isEnabled

Template.clearLogs.events
  "click #clearLogs": -> Logger.clear()
