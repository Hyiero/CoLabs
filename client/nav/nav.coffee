Template.loginButton.events
  'click': ->
    authService = @toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Meteor["loginWith#{authService}"]()
    
Template.loginButton.helpers
  lowerCase: -> @toLowerCase()

Template.navLinks.onCreated ->
  @subscribe 'newMessageCount'

Template.navLinks.rendered = ->
  routeName = Router.current().route.getName()
  linkClicked = document.getElementById routeName
  if linkClicked? then linkClicked.classList.add 'active'
  else console.log 'Nav link has incorrect id (id of element in nav bar does not match route name)'

Template.navLinks.helpers
  isLoggedIn: -> Meteor.user()?
  isVerifiedUser: -> CoLabs.isVerifiedUser()
  isAdmin: -> CoLabs.isAdmin()
  numNewMessages: -> Counts.get 'newMessages'

Template.profileNavDisplay.helpers
  username: ->
    user = Meteor.user()
    if user then user.username else false
  userId: ->
    Meteor.userId()
