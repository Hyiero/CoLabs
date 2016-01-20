createGetter = (context, prop, get) ->
  Object.defineProperty context.prototype, prop,
    get: get
    configurable: true

unimplemented = ->
  console.warn 'Unimplemented!'
  return

mixin = ->
  mixFrom = Array::slice.call(arguments)
  mixTo = mixFrom.pop()
  i = 0
  while i < mixFrom.length
    for property of mixFrom[i]
      if mixFrom[i].hasOwnProperty(property)
        mixTo[property] = mixFrom[i][property]
    i++
  mixTo

getBaseProps = ->
  { attr: (attribute) ->
    id = client.element(@selector).value.ELEMENT
    client.elementIdAttribute(id, attribute).value
  }

getVisibilityProps = ->
  {
  isPresent: ->
    client.isExisting @selector
  isDisplayed: ->
    client.isVisible @selector

  }

getMouseEvents = ->
  {
  click: ->
    client.waitForVisible @selector
    client.click @selector
  hover: ->
    client.waitForVisible @selector
    client.moveToObject @selector
  drag: (destinationSelector) ->
    client.waitForVisible @selector
    client.dragAndDrop @selector, destinationSelector

  }

getKeyboardEvents = ->
  { setValue: (value) ->
    client.waitForVisible @selector
    client.setValue @selector, value
  }

getViewAssertions = ->
  { contains: (text) ->
    (client.getText @selector).then (res) ->
      isFound = false
      res.forEach (item) ->
        if item.indexOf(text) > -1
          isFound = true
      isFound
  }


class Selectable
  constructor: (@selector) ->

class Button extends Selectable
class Link extends Selectable
class Input extends Selectable

class View extends Selectable
  constructor: (@valueOf) ->
    @valueOf = ->
      client.element @selector

class ViewList extends Selectable
  constructor: (@valueOf) ->
    @valueOf = ->
      client.elements @selector


Button.prototype = mixin do getBaseProps,
  do getVisibilityProps,
  do getMouseEvents,
  Button.prototype

Link.prototype = mixin do getBaseProps,
  do getVisibilityProps,
  do getMouseEvents,
  Link.prototype

Input.prototype = mixin do getBaseProps,
  do getVisibilityProps,
  do getMouseEvents,
  do getKeyboardEvents,
  Input.prototype

View.prototype = mixin do getBaseProps,
  do getVisibilityProps,
  do getMouseEvents,
  do getViewAssertions,
  View.prototype

module.exports =
  Button: Button
  Link: Link
  Input: Input
  View: View
