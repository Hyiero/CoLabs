new Csml.Writer context:window

@export = (fnsMap) =>
  @[name] = fn for name, fn of fnsMap

mergeInto = (objTo, objFrom) ->
  for key, val of objFrom
    if (not objTo.hasOwnProperty key) and
      (objFrom.hasOwnProperty key) then objTo[key] = val
  return objTo

filterFrom = (obj, props) ->
  result = {}
  (result[key] = val) for key, val of obj when key not in props
  return result

@export {
  mergeInto: mergeInto
  filterFrom: filterFrom
}

@Render =
  button: (model = {}) ->
    # Merge default properties
    mergeInto model,
      icon: ''
      text: ''
      type: 'default'

    # Construct attributes
    buttonAttributes =
      class: "btn btn-#{model.type}#{
        if model.class then " #{model.class}" else '' }"
      type: if model.isSubmit then 'submit' else 'button'

    # Filter non-attribute properties and merge from model
    mergeInto buttonAttributes,
      filterFrom model,
        ['icon', 'text', 'class', 'type', 'isSubmit']

    console.log buttonAttributes, model

    # Render the component
    (button buttonAttributes,
      (i class:"fa fa-#{model.icon}") if model.icon isnt ''
      (span class:"txt", model.text) if model.text isnt ''
    )

  buttonSave: (model = {}) ->
    mergeInto model,
      icon: 'save'
      text: 'Save'
      type: 'primary'
      isSubmit: true
    Render.button model

  buttonCancel: (model = {}) ->
    mergeInto model,
      icon: 'back'
      text: 'Cancel'
      type: 'default'
    Render.button model

  buttonDelete: (model = {}) ->
    mergeInto model,
      icon: 'trash'
      text: 'Delete'
      type: 'danger'
    Render.button model