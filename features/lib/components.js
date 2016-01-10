
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

mixin = function (mixFrom, mixTo) {
  
  for (var property in mixFrom) {
    if (mixFrom.hasOwnProperty(property)) {
      mixTo[property] = mixFrom[property]
    }
  }
  
  return mixTo;
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

// TODO: mixin should accept multiple objects to mix from
// mixin(mixFrom1, mixFrom2, mixTarget)
Button.prototype = mixin(
  getVisibilityProps(),
  mixin(
    getMouseEvents(),
    Button.prototype
  )
)

Link.prototype = mixin(
  getVisibilityProps(),
  mixin(
    getMouseEvents(),
    Link.prototype
  )
)

console.log(Button.toString())

exports.Button = Button
exports.Link = Link

console.log(exports)