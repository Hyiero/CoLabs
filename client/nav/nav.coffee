Template.loginButton.events
  'click': ->
    authService = this.toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Meteor["loginWith#{authService}"]()
    
Template.loginButton.helpers
  lowerCase: -> this.toLowerCase()

Template.navLinks.rendered = ->
  routeName = Router.current().route.getName()
  linkClicked = document.getElementById routeName
  if linkClicked? then linkClicked.classList.add('active')
  else console.log 'Nav link has incorrect id (id of element in nav bar does not match route name)'

Template.navLinks.helpers
  isLoggedIn: -> Meteor.user()?
  isVerifiedUser: -> CoLabs.isVerifiedUser Meteor.userId()
  numNewMessages: -> Messages.newMessages(Meteor.userId()).length

Template.profileNavDisplay.helpers
  username: ->
    user = Meteor.user()
    if user then user.username else false
  userId: ->
    Meteor.userId()
