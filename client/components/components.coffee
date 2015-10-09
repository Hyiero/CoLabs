new Jsml.Writer context:window

mergeInto = (objTo, objFrom) ->
  for key, val of objFrom
    if (not objTo.hasOwnProperty key) and
      (objFrom.hasOwnProperty key) then objTo[key] = val
  return objTo

filterFrom = (obj, props) ->
  result = {}
  (result[key] = val) for key, val of obj when key not in props
  return result

sendTo window,
  mergeInto: mergeInto
  filterFrom: filterFrom

createRenderFn = (fn) -> (model = {}) -> fn.call model

@Render =
  button: createRenderFn ->
    # Merge default properties
    mergeInto @,
      icon: ''
      text: ''
      type: 'default'
      isEnabled: null

    # Construct attributes
    buttonAttributes =
      class: "btn btn-#{@type}#{
        if @class then " #{@class}" else '' }"
      type: if @isSubmit then 'submit' else 'button'

    # Filter non-attribute properties and merge from model
    mergeInto buttonAttributes,
      filterFrom @,
        ['icon', 'text', 'class', 'type', 'isSubmit', 'isEnabled']

    #console.log buttonAttributes, @

    # Render the component
    (button buttonAttributes,
      (i class:"fa fa-#{@icon}") if @icon isnt ''
      (span class:"txt", @text) if @text isnt ''
      if @isEnabled?
        if @isEnabled then (i class:"fa fa-toggle-on")
        else (i class:"fa fa-toggle-off")
    )

  buttonSave: createRenderFn ->
    mergeInto @,
      icon: 'save'
      text: 'Save'
      type: 'primary'
      isSubmit: true
    Render.button @
    
  buttonImportant: createRenderFn ->
    mergeInto @,
      icon: 'warning'
      type: 'warning'
    Render.button @

  buttonCancel: createRenderFn ->
    mergeInto @,
      icon: 'back'
      text: 'Cancel'
      type: 'default'
    Render.button @

  buttonDelete: createRenderFn ->
    mergeInto @,
      icon: 'trash'
      text: 'Delete'
      type: 'danger'
    Render.button @
    
  buttonClose: createRenderFn ->
    mergeInto @, icon: 'close'
    Render.button @
    
  buttonToggle: createRenderFn ->
    mergeInto @,
      icon: 'trash'
      text: 'Delete'
      type: 'danger'
      isEnabled: false
    Render.button @