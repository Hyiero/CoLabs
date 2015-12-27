sendTo window, setLogging: (enable) ->
  method = if enable then 'Enable' else 'Disable'
  toast.info "Success!", "#{method}d log persistence", 1000
  Logger[method.toLowerCase()]()
  Session.set 'logEnabled', Logger.isEnabled

Template.admin.helpers
  adminPowersButton: -> Render.buttonDelete
    text: 'Add/Remove Admins'
    icon: 'user-plus'
    onclick: -> Router.go '/admin/power'
  buttonRunTerminal: -> Render.buttonSave
    class: 'form-control'
    icon: 'terminal'
    text: 'Run'
    onclick: -> console.log eval $('[name=command]').val()
  buttonEnableLogs: -> Render.buttonToggle
    type: 'info'
    icon: 'feed'
    text: 'Persist Logs'
    isEnabled: Session.get 'logEnabled'
    onclick: -> setLogging not Logger.isEnabled
  buttonClearLogs: -> Render.buttonDelete
    text: 'Delete All Logs'
    class: 'pull-right'
    onclick: -> Logger.clear()
