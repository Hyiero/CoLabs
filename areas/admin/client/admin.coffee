Template.admin.helpers
  buttonRunTerminal: -> Render.buttonSave
    id: 'runTerminal'
    class: 'form-control'
    icon: 'terminal'
    text: 'Run'
    onclick: -> console.log eval $('[name=command]').val()

Template.enableLogs.onCreated ->
  Session.set 'logEnabled', Logger.isEnabled

sendTo window, setLogging: (enable) ->
  method = if enable then 'Enable' else 'Disable'
  toast.info "Success!", "#{method}d log persistence", 1000
  Logger[method.toLowerCase()]()

Template.enableLogs.helpers
  buttonEnableLogs: -> Render.buttonToggle
    type: 'info'
    icon: 'feed'
    text: 'Persist Logs'
    isEnabled: Session.get 'logEnabled'
    onclick:  ->
      setLogging not Logger.isEnabled
      Session.set 'logEnabled', Logger.isEnabled

Template.clearLogs.events
  "click #clearLogs": -> Logger.clear()
