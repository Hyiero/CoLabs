
var components = require('./components.js')
var Button = components.Button
var Link = components.Link
var Input = components.Input
var View = components.View

var nav = {
  
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
    nav: nav
  },
  baseUrl: 'http://dev.colabs.biz/',
  pages: require('./pages.js'),
  components: require('./components.js'),
  modals: require('./modals.js')
}

module.exports = app
