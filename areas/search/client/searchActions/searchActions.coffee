Template.searchActionCheckbox.onCreated = ->
  id = this._id or this.id
  if not id? then throw new Error 'Need an id!'
  if not Session.get "checkbox-#{id}"
    Session.set "checkbox-#{id}", this.default or false

Template.searchActionCheckbox.helpers
  id: -> this._id or this.id
  hide: ->
    id = this._id or this.id
    if Session.get "checkbox-#{id}" then '' else 'hide'
  
Template.searchActionCheckbox.events
  "click": ->
    id = this._id or this.id
    Session.set "checkbox-#{id}",
      !(Session.get "checkbox-#{id}")