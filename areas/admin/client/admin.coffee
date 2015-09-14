Template.enableLogs.helpers
  isEnabled: -> Logger.isEnabled
  
Template.enableLogs.events
  "click #toggleLogs": ->
     if Logger.isEnabled then Logger.disable()
     else Logger.enable()