
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
      return client.click(this.selector)
    },
    
    hover: function () {
      return client.moveToObject(this.selector)
    },
    
    drag: function (destinationSelector) {
      return client.dragAndDrop(this.selector, destinationSelector)
    }
  }
}

function getKeyboardEvents() {
  return {
    setValue: function (value) {
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
}

Button.prototype = mixin(
  getVisibilityProps(),
  getMouseEvents(),
  Button.prototype)

Link.prototype = mixin(
  getVisibilityProps(),
  getMouseEvents(),
  Link.prototype)

Input.prototype = mixin(
  getVisibilityProps(),
  getMouseEvents(),
  getKeyboardEvents(),
  Input.prototype)

View.prototype = mixin(
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
