
var components = require('./components.js')
var Button = components.Button
var Link = components.Link
var Input = components.Input
var View = components.View


// app.views.toasts(0).getText('inner html text')
// app.views.toasts(1).getAttribute('class')
// app.views.toasts().count
var toasts = function (index) {
  
  var getToasts = function () {
    return client.elements('.toast')
      .then(function (toasts) {
        return toasts[index]
      })
  }
  return {
    
    getText: function (text) {
      return getToasts().getText(text)
    },
    
    getAttribute: function (attrName) {
      return getToasts().getAttribute(attrName)
    }
    
    
  }
}

// toast = (ind) -> ->
//   getText: ->
//   getAttribute: ->
  
  
  
  //var toasts = client.getText('.toast')
  //  toasts.forEach()
  
  // client.elements[index]
  // 
  
  


var nav = {

  buttons: {
    collapse: new Button('#navbarCollapse')
  },
  
  links: {
    splash: new Link('#splashLink'),

    home: new Link('#homeLink'),

    search: new Link('#searchLink'),

    profile: new Link('#profileLink'),

    projects: new Link('#projectsLink'),

    inbox: new Link('#inboxLink'),

    notifications: new Link('#notificationsLink'),

    admin: new Link('#adminLink'),
    
    signIn: new Link('#signIn'),
    
    signOut: new Link('#signOut')
  }
  
}

var app = {
  views: {
    nav: nav,
    toasts: toasts
  },
  baseUrl: 'http://dev.colabs.biz/',
  pages: require('./pages.js'),
  components: require('./components.js'),
  modals: require('./modals.js')
}

module.exports = app
