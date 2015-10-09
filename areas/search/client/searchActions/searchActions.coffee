Template.searchActionCheckbox.onCreated ->
  id = @_id or @id
  if not id? then throw new Error 'Need an id!'
  if not Session.get "checkbox-#{id}"
    Session.set "checkbox-#{id}", @default or false

Template.searchActionCheckbox.helpers
  id: -> @_id or @id
  hide: ->
    id = @_id or @id
    if Session.get "checkbox-#{id}" then '' else 'hide'
  
Template.searchActionCheckbox.events
  "click": ->
    id = @_id or @id
    Session.set "checkbox-#{id}",
      !(Session.get "checkbox-#{id}")