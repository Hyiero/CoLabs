new Jsml.Writer context:window

mergeInto = (objTo, objFrom) ->
  for key, val of objFrom
    if (objFrom.hasOwnProperty key) and
      (not objTo.hasOwnProperty key) then objTo[key] = val

deepMerge = (objTo, objFrom) ->
  for key, val of objFrom
    if (objFrom.hasOwnProperty key)
      if (typeof val is 'object')
       unless objTo[key]? then objTo[key] = {}
       mergeInto objTo[key], val
     else if (not objTo.hasOwnProperty key) then objTo[key] = val

filterFrom = (obj, props) ->
  result = {}
  (result[key] = val) for key, val of obj when key not in props
  return result

sendTo window,
  mergeInto: mergeInto
  filterFrom: filterFrom

createRenderFn = (fn) -> (model = {}) -> fn.call model

@Render =

  tag: createRenderFn ->
    unless @name? then throw new Error "Tag requires a name"

    attributes = {}
    mergeInto attributes, filterFrom @, ['name', 'isEdit']
    deepMerge attributes, style: position: 'relative'
    # TODO: Pick a color based on the name (convert to hex code somehow)

    component = if @isEdit then button else div

    if component is div
      className = "alert alert-info"
      if attributes.class? then attributes.class += " #{className}"
      else attributes.class = className

    console.log attributes

    ###
      TODO/FIX: Why does a class attribute break the style?
      Render.tags({tags: ['test','one'] })
        vs.
      Render.tags({tags: ['test','one'], isEdit: true})
    ###

    (component attributes,
      (span {}, @name)
      (if @isEdit then Render.buttonClose style: {
        position: 'absolute'
        top: 0
        right: 0
      })
    )

  tags: createRenderFn ->
    (Render.tag {
      name: tag
      isEdit: @isEdit
    } for tag in @tags).join ''

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

