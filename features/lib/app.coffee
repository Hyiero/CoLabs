components = require('./components.js')
Button = components.Button
Link = components.Link
Input = components.Input
View = components.View

toasts = (index) ->

  getToasts = ->
    client.elements('.toast').then (toasts) ->
      toasts[index]

  {
  getText: (text) ->
    getToasts().getText text
  getAttribute: (attrName) ->
    getToasts().getAttribute attrName

  }

nav =
  buttons: collapse: new Button '#navbarCollapse'
  links:
    splash: new Link '#splashLink'
    home: new Link '#homeLink'
    search: new Link '#searchLink'
    profile: new Link '#profileLink'
    projects: new Link '#projectsLink'
    inbox: new Link '#inboxLink'
    notifications: new Link '#notificationsLink'
    admin: new Link '#adminLink'
    signIn: new Link '#signIn'
    signOut: new Link '#signOut'
  profileInfo: new View '.profile-nav-display'
app =
  views:
    nav: nav
    toasts: toasts
  baseUrl: 'http://localhost:3000/'
  pages: require './pages.js'
  components: require './components.js'
  modals: require './modals.js'

module.exports = app
