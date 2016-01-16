
function createGetter(context, prop, get) {
  return Object.defineProperty(
    context.prototype, prop, {
      get: get,
      configurable: true
  })
}

function unimplemented() {
  console.warn('Unimplemented!')
}

function mixin() {
  var mixFrom = Array.prototype.slice.call(arguments)
  var mixTo = mixFrom.pop()

  for (var i = 0; i < mixFrom.length; i++) {
    for (var property in mixFrom[i]) {
      if (mixFrom[i].hasOwnProperty(property)) {
        mixTo[property] = mixFrom[i][property]
      }
    }
  }
  
  return mixTo
}

function getBaseProps() {
  return {
    attr: function (attribute) {
      var id = client.element(this.selector).value.ELEMENT
      return client.elementIdAttribute(id, attribute).value
    }
  }
}

function getVisibilityProps() {
  return {
    isPresent: function () {
      return client.isExisting(this.selector)
    },
    
    isDisplayed: function () {
      return client.isVisible(this.selector)
    }
  }
}

function getMouseEvents() {
  return {
    click: function () {
      client.waitForVisible(this.selector)
      return client.click(this.selector)
    },
    
    hover: function () {
      client.waitForVisible(this.selector)
      return client.moveToObject(this.selector)
    },
    
    drag: function (destinationSelector) {
      client.waitForVisible(this.selector)
      return client.dragAndDrop(this.selector, destinationSelector)
    }
  }
}

function getKeyboardEvents() {
  return {
    setValue: function (value) {
      client.waitForVisible(this.selector)
      return client.setValue(this.selector, value)
    }
  }
}

function getViewAssertions() {
  return {
    contains: function (text) {
      return client.getText(this.selector)
        .then(function (res) {
          var isFound = false
          res.forEach(function (item) {
            if (item.indexOf(text) > -1) isFound = true
          })
          
          return isFound
        })
    }
  }
}



function Button(selector) {
  this.selector = selector
}

function Link(selector) {
  this.selector = selector
}

function Input(selector) {
  this.selector = selector
}

function View(selector) {
  this.selector = selector
  this.valueOf = function () {
    return client.element(this.selector)
  }
}

function ViewList(selector) {
  this.selector = selector
  this.valueOf = function () {
    return client.elements(this.selector)
  }
}


Button.prototype = mixin(
  getBaseProps(),
  getVisibilityProps(),
  getMouseEvents(),
  Button.prototype)

Link.prototype = mixin(
  getBaseProps(),
  getVisibilityProps(),
  getMouseEvents(),
  Link.prototype)

Input.prototype = mixin(
  getBaseProps(),
  getVisibilityProps(),
  getMouseEvents(),
  getKeyboardEvents(),
  Input.prototype)

View.prototype = mixin(
  getBaseProps(),
  getVisibilityProps(),
  getMouseEvents(),
  getViewAssertions(),
  View.prototype)


module.exports = {
  Button: Button,
  Link: Link,
  Input: Input,
  View: View
}
