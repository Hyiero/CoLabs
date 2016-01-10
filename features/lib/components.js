
createGetter = function (context, prop, get) {
  return Object.defineProperty(
    context.prototype, prop, {
      get: get,
      configurable: true
  })
}

unimplemented = function () {
  console.warn('Unimplemented!')
}

mixin = function () {
  var mixFrom = Array.prototype.slice.call(arguments, 0, arguments.length - 1)
  var mixTo = arguments[arguments.length - 1]

  for (var i = 0; i < mixFrom.length; i++) {
    for (var property in mixFrom[i]) {
      if (mixFrom[i].hasOwnProperty(property)) {
        mixTo[property] = mixFrom[i][property]
      }
    }
  }
  
  return mixTo
}


var getVisibilityProps = function () {
  return {
    // TODO: get isPresent() {
    isPresent: function () {
      unimplemented()
      //return client.waitForExist(this.selector)
    },
    
    // TODO: get isDisplayed() {
    isDisplayed: function () {
      unimplemented()
      //return client.isDisplayed(this.selector)
    }
  }
}

var getMouseEvents = function () {
  return {
    click: function () {
      return client.click(this.selector)
    },
    
    hover: function () {
      unimplemented()
    },
    
    drag: function () {
      unimplemented()
    }
  }
}


var Button = function (selector) {
  this.selector = selector
}

var Link = function (selector) {
  this.selector = selector
}

Button.prototype = mixin(
  getVisibilityProps(),
  getMouseEvents(),
  Button.prototype
)

Link.prototype = mixin(
  getVisibilityProps(),
  getMouseEvents(),
  Link.prototype
)

console.log(Button.toString())

exports.Button = Button
exports.Link = Link

console.log(exports)